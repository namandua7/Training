import torch
import torch.nn.functional as F
from torch.utils.data import DataLoader, Dataset
from transformers import AutoTokenizer
from model import Transformer
from utils import encode, decode, get_batch, estimate_loss, save_model_to_chekpoint

# Hyperparameters
BATCH_SIZE = 32
BLOCK_SIZE = 64
LEARNING_RATE = 3e-4
MAX_ITER = 5
EVAL_INTER = 500
NUM_EMBED = 256
NUM_HEAD = 4
NUM_LAYER = 4
DROPOUT = 0.2

# Load pre-trained tokenizer
tokenizer = AutoTokenizer.from_pretrained("bert-base-uncased")
vocab_size = tokenizer.vocab_size

# Define the dataset class
class TextDataset(Dataset):
    def __init__(self, data, block_size):
        self.data = data
        self.block_size = block_size
    
    def __len__(self):
        return len(self.data) - self.block_size
    
    def __getitem__(self, idx):
        return self.data[idx : idx + self.block_size]

# Load preprocessed data
data_path = "data/english.txt"  # Adjust the path to your preprocessed data
with open(data_path, encoding="utf-8") as f:
    data_raw = f.read()
data = encode(text_seq=data_raw, tokenizer=tokenizer)

# Instantiate the dataset and dataloader
train_dataset = TextDataset(data, block_size=BLOCK_SIZE)
train_loader = DataLoader(train_dataset, batch_size=BATCH_SIZE, shuffle=True)

# Instantiate the model
model = Transformer(
    vocab_size=vocab_size,
    num_embed=NUM_EMBED,
    block_size=BLOCK_SIZE,
    num_heads=NUM_HEAD,
    num_layers=NUM_LAYER,
    dropout=DROPOUT,
)
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)

# Define the optimizer
optimizer = torch.optim.AdamW(model.parameters(), lr=LEARNING_RATE)

# Training loop
for step in range(MAX_ITER):
    if step % EVAL_INTER == 0 or step == MAX_ITER - 1:
        loss_train = estimate_loss(
            data=train_dataset.data, model=model, block_size=BLOCK_SIZE, batch_size=BATCH_SIZE
        )
        print("step {:10} | train loss {:6.4f}".format(step, loss_train))
    
    # Sample a batch of data
    xb, yb = get_batch(data=train_dataset.data, block_size=BLOCK_SIZE, batch_size=BATCH_SIZE)
    logits, loss = model.forward(xb, yb)
    optimizer.zero_grad(set_to_none=True)
    loss.backward()
    optimizer.step()

    # Save model checkpoint
    save_model_to_chekpoint(model=model, path_to_checkpoint="checkpoints", epoch=step)

print("Training finished!")

# Generate some output based on the context
context = torch.zeros((1, BLOCK_SIZE), dtype=torch.long, device=device)
generated_text = decode(
    enc_sec=model.generate(idx=context, max_new_tokens=100, block_size=BLOCK_SIZE)[0],
    tokenizer=tokenizer,
)
print("Generated text:", generated_text)

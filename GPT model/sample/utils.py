import os
import torch
from datetime import datetime

# Hyperparameters
BATCH_SIZE = 32
BLOCK_SIZE = 64
MAX_ITER = 5
EVAL_INTER = 500
LEARNING_RATE = 3e-4
DEVICE = "cuda" if torch.cuda.is_available() else "cpu"
NUM_HEAD = 6
NUM_EMBED = NUM_HEAD * 128
NUM_LAYER = 6
DROPOUT = 0.2

def encode(text_seq: str, tokenizer: any) -> torch.Tensor:
    tokens = tokenizer.tokenize(text_seq)
    token_indices = tokenizer.convert_tokens_to_ids(tokens)
    token_indices = torch.tensor(token_indices, dtype=torch.long)
    return token_indices

def decode(enc_sec: torch.Tensor, tokenizer: any) -> str:
    enc_sec = enc_sec.tolist()
    text = tokenizer.decode(enc_sec)
    return text

def get_batch(data: torch.Tensor, block_size: int, batch_size: int):
    ix = torch.randint(len(data) - block_size, (batch_size,))
    x = torch.stack([data[i : i + block_size] for i in ix])
    y = torch.stack([data[i + 1 : i + block_size + 1] for i in ix])
    x, y = x.to(DEVICE), y.to(DEVICE)
    return x, y

@torch.no_grad()
def estimate_loss(data: torch.Tensor, model: torch.nn.Module, block_size: int, batch_size: int, eval_iters: int = 10):
    out = {}
    model.eval()
    losses = torch.zeros(eval_iters)
    for k in range(eval_iters):
        X, Y = get_batch(data=data, block_size=block_size, batch_size=batch_size)
        logits, loss = model.forward(X, Y)
        losses[k] = loss.item()
    out = losses.mean()
    model.train()
    return out

def load_model_from_checkpoint(model_class: torch.nn.Module, path_to_checkpoint: str = "checkpoints/state_dict_model.pt", **kwargs: dict) -> torch.nn.Module:
    try:
        state_dict = torch.load(path_to_checkpoint)
        print("Successfully loaded model from the checkpoint")
    except Exception as e:
        print(f"Error loading the model from the checkpoint. {e}")

    model = model_class(**kwargs)
    model.load_state_dict(state_dict)
    return model

def save_model_to_chekpoint(model: torch.nn.Module, path_to_checkpoint: str = "checkpoints", epoch: int = 0):
    if not os.path.exists(path_to_checkpoint):
        os.makedirs(path_to_checkpoint)
    
    now = datetime.now()
    dt_string = now.strftime("%d_%m_%Y_%H_%M_%S")
    checkpoint_name = f"checkpoint_epoch-{epoch}_{dt_string}.pt"
    full_path = os.path.join(path_to_checkpoint, checkpoint_name)
    try:
        torch.save(model.state_dict(), full_path)
        print("Successfully saved the model to {}".format(full_path))
    except Exception as e:
        print(f"Error saving the model to checkpoint. {e}")

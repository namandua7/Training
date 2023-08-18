import torch
from transformers import GPT2LMHeadModel, GPT2Tokenizer
from torch.utils.data import Dataset, DataLoader

# Define a custom dataset for training
class MyselfDataset(Dataset):
    def __init__(self, input_ids_file, target_ids_file):
        self.input_ids = torch.load(input_ids_file)
        self.target_ids = torch.load(target_ids_file)

    def __len__(self):
        return len(self.input_ids)

    def __getitem__(self, index):
        input_ids = self.input_ids[index]
        target_ids = self.target_ids[index]
        return input_ids, target_ids

# Set the device
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# Load the pre-trained GPT-2 tokenizer and model
tokenizer = GPT2Tokenizer.from_pretrained("gpt2")
model = GPT2LMHeadModel.from_pretrained("gpt2")

# Set the model to training mode
model.train()

# Path to the preprocessed data
input_ids_file = "input_ids.pt"
target_ids_file = "target_ids.pt"

# Create a MyselfDataset instance
dataset = MyselfDataset(input_ids_file, target_ids_file)

# Create a DataLoader for efficient batch processing
batch_size = 8
dataloader = DataLoader(dataset, batch_size=batch_size, shuffle=True)

# Training parameters
num_epochs = 3
learning_rate = 1e-4

# Define the optimizer and loss function
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
criterion = torch.nn.CrossEntropyLoss()

# Training loop
for epoch in range(num_epochs):
    total_loss = 0
    total_steps = 0

    for input_ids, target_ids in dataloader:
        input_ids = input_ids.to(device)
        target_ids = target_ids.to(device)

        # Forward pass
        outputs = model(input_ids, labels=target_ids)

        # Compute the loss
        loss = outputs.loss

        # Backward pass
        optimizer.zero_grad()
        loss.backward()

        # Update the model parameters
        optimizer.step()

        total_loss += loss.item()
        total_steps += 1

    # Print the average loss for the epoch
    average_loss = total_loss / total_steps
    print(f"Epoch {epoch+1}/{num_epochs} - Average Loss: {average_loss:.4f}")

# Save the trained model
output_dir = "trained_model"
model.save_pretrained(output_dir)
tokenizer.save_pretrained(output_dir)

import torch
import torch.nn as nn
from transformers import GPT2LMHeadModel, GPT2Tokenizer
from data_preprocess import input_ids

# Load pre-trained GPT-2 model and tokenizer
model_name = "gpt2"
model = GPT2LMHeadModel.from_pretrained(model_name)
tokenizer = GPT2Tokenizer.from_pretrained(model_name)

# Set device
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)
input_ids = input_ids.to(device)

# Define training parameters
batch_size = 1
learning_rate = 1e-4
num_epochs = 5

# Prepare optimizer and loss function
optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)
criterion = nn.CrossEntropyLoss()

# Training loop
for epoch in range(num_epochs):
    model.train()
    total_loss = 0.0

    for i in range(0, len(input_ids), batch_size):
        batch_input_ids = input_ids[i : i + batch_size]

        optimizer.zero_grad()
        outputs = model(
            input_ids=batch_input_ids,
            labels=batch_input_ids,  # Auto-regressive training
        )

        loss = outputs.loss
        loss.backward()
        optimizer.step()

        total_loss += loss.item()

        if (i + batch_size) % 500 == 0:
            print(f"Epoch [{epoch+1}/{num_epochs}] | Step [{i+1}/{len(input_ids)}] | Loss: {total_loss / (i+1):.4f}")

    print(f"Epoch [{epoch+1}/{num_epochs}] | Average Loss: {total_loss / len(input_ids):.4f}")

# Save the trained model
model.save_pretrained("trained_gpt2_model")
tokenizer.save_pretrained("trained_gpt2_model")

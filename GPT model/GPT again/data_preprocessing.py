import torch
from transformers import GPT2Tokenizer

# Load pre-trained GPT-2 tokenizer
tokenizer = GPT2Tokenizer.from_pretrained("gpt2")

# Read the text from the file
file_path = "data.txt"
with open(file_path, "r", encoding="utf-8") as file:
    text = file.read()

# Tokenize the text
tokens = tokenizer.tokenize(text)

# Convert tokens to input IDs
input_ids = tokenizer.convert_tokens_to_ids(tokens)

# Create target IDs by shifting input IDs by one position
target_ids = input_ids[1:]  # Shift input IDs by one position
# For the last token in each sequence, set it to the end-of-sequence token ID
target_ids.append(tokenizer.eos_token_id)

# Convert to tensors
input_ids = torch.tensor(input_ids).unsqueeze(0)  # Add batch dimension
target_ids = torch.tensor(target_ids).unsqueeze(0)  # Add batch dimension

filename_input = "input_ids.pt"
filename_target = "target_ids.pt"
# Save the tensor using torch.save
torch.save(input_ids, filename_input)
torch.save(target_ids, filename_target)

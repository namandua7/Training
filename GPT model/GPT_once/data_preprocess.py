import torch
from transformers import GPT2Tokenizer

# Load pre-trained GPT-2 tokenizer
tokenizer = GPT2Tokenizer.from_pretrained("gpt2")

# Read the passage from the file
file_path = "data.txt"
with open(file_path, "r", encoding="utf-8") as file:
    passage = file.read()

# Tokenize the passage
tokens = tokenizer.tokenize(passage)

# Convert tokens to input IDs
input_ids = tokenizer.convert_tokens_to_ids(tokens)

# Convert to a tensor
input_ids = torch.tensor(input_ids)

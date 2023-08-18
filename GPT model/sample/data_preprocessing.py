import torch
from transformers import AutoTokenizer
from utils import get_batch

def load_and_tokenize_data(file_path, tokenizer, block_size, batch_size):
    data_raw = open(file_path, encoding="utf-8").read()
    data = tokenizer.encode(data_raw)  # Tokenize and convert to token indices
    
    # Split data into train and validation sets
    n = int(0.9 * len(data))
    train_data = data[:n]
    val_data = data[n:]
    
    # Create data loaders
    train_loader = get_batch(train_data, block_size, batch_size)
    val_loader = get_batch(val_data, block_size, batch_size)
    
    return train_loader, val_loader

if __name__ == "__main__":
    # Hyperparameters
    BATCH_SIZE = 32
    BLOCK_SIZE = 64
    
    # Load pre-trained tokenizer
    tokenizer = AutoTokenizer.from_pretrained("bert-base-uncased")
    
    # Load and tokenize data
    train_loader, val_loader = load_and_tokenize_data(
        file_path="data/english.txt",
        tokenizer=tokenizer,
        block_size=BLOCK_SIZE,
        batch_size=BATCH_SIZE,
    )
    
    # Count the number of batches
    train_batch_count = sum(1 for _ in train_loader)
    val_batch_count = sum(1 for _ in val_loader)
    
    print("Number of training batches:", train_batch_count)
    print("Number of validation batches:", val_batch_count)

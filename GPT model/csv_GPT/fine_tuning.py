import json
import torch
from torch.utils.data import Dataset
from transformers import GPT2LMHeadModel, GPT2Tokenizer, DataCollatorForLanguageModeling, Trainer, TrainingArguments
from data_preprocess import *

# Load the JSON file with prompt-completion pairs
with open("prompt_completion_pairs.json", "r") as json_file:
    prompt_completion_pairs = json.load(json_file)

# Load the GPT-2 model and tokenizer
model_name = "gpt2"
tokenizer = GPT2Tokenizer.from_pretrained(model_name)

# Add a pad token to the tokenizer's vocabulary
pad_token = "<PAD>"
tokenizer.add_special_tokens({"pad_token": pad_token})

# Load the GPT-2 model
model = GPT2LMHeadModel.from_pretrained(model_name)

# Define a custom dataset class
class CustomDataset(torch.utils.data.Dataset):
    def __init__(self, tokenizer, pairs, block_size):
        self.examples = []
        for pair in pairs:
            prompt = pair["prompt"]
            completion = pair["completion"]
            self.examples.append((prompt, completion))
        self.tokenizer = tokenizer
        self.block_size = block_size

    def __len__(self):
        return len(self.examples)

    def __getitem__(self, index):
        prompt, completion = self.examples[index]
        input_text = f"{prompt}\n{completion}"
        input_ids = self.tokenizer.encode(input_text, add_special_tokens=True)
        return torch.tensor(input_ids)


# Prepare data for fine-tuning
train_dataset = CustomDataset(tokenizer=tokenizer, pairs=prompt_completion_pairs, block_size=32)
data_collator = DataCollatorForLanguageModeling(tokenizer=tokenizer, mlm=False)  # mlm=False disables masking


# # Set up training arguments
training_args = TrainingArguments(
    output_dir="./output",
    overwrite_output_dir=True,
    num_train_epochs=5,
    per_device_train_batch_size=4,
    save_steps=500,
    save_total_limit=2,
    logging_dir="./logs",
    logging_steps=100,
    do_train=True,
)

# Initialize Trainer and start fine-tuning
trainer = Trainer(
    model=model,
    args=training_args,
    data_collator=data_collator,
    train_dataset=train_dataset,
)

trainer.train()

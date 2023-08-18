from transformers import GPT2LMHeadModel, GPT2Tokenizer
from transformers import Trainer, TrainingArguments
from transformers import TextDataset, DataCollatorForLanguageModeling

# Load your pre-trained GPT-2 model and tokenizer
pretrained_model_dir = "trained_model"  # Path to your pre-trained model
model = GPT2LMHeadModel.from_pretrained(pretrained_model_dir)
tokenizer = GPT2Tokenizer.from_pretrained(pretrained_model_dir)

# Define paths to your fine-tuning dataset
fine_tuning_dataset_path = "data_input_output.txt"  # Input-output pairs file

# Create a fine-tuning dataset using TextDataset
dataset = TextDataset(
    tokenizer=tokenizer,
    file_path=fine_tuning_dataset_path,
    block_size=32  # Adjust this based on your input-output pairs
)

# Define data collator
data_collator = DataCollatorForLanguageModeling(
    tokenizer=tokenizer,
    mlm=False
)

# Fine-tuning training arguments
training_args = TrainingArguments(
    output_dir="./fine_tuned_model",  # Output directory
    overwrite_output_dir=True,
    num_train_epochs=3,
    per_device_train_batch_size=8,
    save_steps=10_000,
    save_total_limit=2,
)

# Create a Trainer instance
trainer = Trainer(
    model=model,
    args=training_args,
    data_collator=data_collator,
    train_dataset=dataset,
)

# Start fine-tuning
trainer.train()

# Save the fine-tuned model
fine_tuned_output_dir = "fine_tuned_model"
model.save_pretrained(fine_tuned_output_dir)
tokenizer.save_pretrained(fine_tuned_output_dir)

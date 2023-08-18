import torch
from transformers import GPT2LMHeadModel, GPT2Tokenizer

# Load trained GPT-2 model and tokenizer
model_name = "trained_gpt2_model"
model = GPT2LMHeadModel.from_pretrained(model_name)
tokenizer = GPT2Tokenizer.from_pretrained(model_name)

# Set device
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)

# Chat loop
print("ChatGPT: Hello! How can I assist you today?")
while True:
    user_input = input("You: ")

    # Check if user wants to exit
    if user_input.lower() == "exit":
        break

    # Tokenize user input
    input_ids = tokenizer.encode(user_input, return_tensors="pt").to(device)

    # Generate response with beam search and adjusted parameters
    with torch.no_grad():
        output = model.generate(
            input_ids,
            max_length=200,  # Adjust max length
            num_return_sequences=1,
            pad_token_id=tokenizer.eos_token_id,  # Set pad token ID
            temperature=0.8,  # Adjust temperature
            no_repeat_ngram_size=2,  # Prevent repeating bigrams
            num_beams=5  # Use beam search
        )

    response = tokenizer.decode(output[0], skip_special_tokens=True)
    print("ChatGPT:", response)

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
    
    # Tokenize user input
    input_ids = tokenizer.encode(user_input, return_tensors="pt").to(device)
    
    # Generate response with attention mask and pad token ID set
    with torch.no_grad():
        attention_mask = torch.ones(input_ids.shape, device=device)  # Create attention mask
        output = model.generate(
            input_ids,
            attention_mask=attention_mask,  # Set attention mask
            max_length=50, 
            num_return_sequences=1,
            pad_token_id=tokenizer.eos_token_id  # Set pad token ID to eos_token_id
        )
    
    response = tokenizer.decode(output[0], skip_special_tokens=True)
    print("ChatGPT:", response)

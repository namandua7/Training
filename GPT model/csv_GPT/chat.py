from transformers import GPT2LMHeadModel, GPT2Tokenizer
import torch

# Load the fine-tuned GPT-2 model and tokenizer
fine_tuned_model_name = "./fine_tuned_model"
model = GPT2LMHeadModel.from_pretrained(fine_tuned_model_name)
tokenizer = GPT2Tokenizer.from_pretrained(fine_tuned_model_name)

# Set the model to evaluation mode
model.eval()

# Chat loop
print("ChatGPT: Hello! How can I assist you today?")
while True:
    user_input = input("You: ")

    # Check if the user wants to exit
    if user_input.lower() == "exit":
        break

    # Tokenize user input
    input_ids = tokenizer.encode(user_input, return_tensors="pt")

    # Generate response
    with torch.no_grad():
        output = model.generate(
            input_ids,
            max_length=100,  # Adjust the length as needed
            num_return_sequences=1,
            pad_token_id=tokenizer.eos_token_id,  # Set pad token ID
            temperature=0.8,  # Adjust temperature for response randomness
            top_k=50,  # Adjust top_k for controlling diversity
        )

    generated_response = tokenizer.decode(output[0], skip_special_tokens=True)
    print("ChatGPT:", generated_response)

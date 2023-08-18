import torch
from transformers import AutoTokenizer
from model import Transformer
from utils import encode, decode
# Load pre-trained tokenizer
tokenizer = AutoTokenizer.from_pretrained("bert-base-uncased")
vocab_size = tokenizer.vocab_size

# Instantiate the model
model = Transformer(
    vocab_size=vocab_size,
    num_embed=256,  # Adjust this to match your model's configuration
    block_size=64,  # Adjust this to match your model's configuration
    num_heads=4,    # Adjust this to match your model's configuration
    num_layers=4,   # Adjust this to match your model's configuration
    dropout=0.2     # Adjust this to match your model's configuration
)

# Load the trained model checkpoint
checkpoint_path = "checkpoints/checkpoint_epoch-4_04_08_2023_14_57_28.pt"  # Adjust this to match your saved checkpoint
model.load_state_dict(torch.load(checkpoint_path))
model.eval()

def generate_response(prompt, max_tokens=100):
    context = encode(prompt, tokenizer)
    context = torch.tensor(context, dtype=torch.long).unsqueeze(0)
    context = context.to(device)

    generated_text = decode(
        enc_sec=model.generate(idx=context, max_new_tokens=max_tokens, block_size=64),
        tokenizer=tokenizer,
    )
    return generated_text
if __name__ == "__main__":
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model.to(device)
    import torch
    from transformers import GPT2LMHeadModel, GPT2Tokenizer
    
    # Load pre-trained GPT model and tokenizer
    model_name = 'gpt2'
    tokenizer = GPT2Tokenizer.from_pretrained(model_name)
    model = GPT2LMHeadModel.from_pretrained(model_name)
    
    # Set device
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model.to(device)
    
    def generate_response(prompt, max_length=50):
        input_ids = tokenizer.encode(prompt, return_tensors='pt').to(device)
        output = model.generate(input_ids, max_length=max_length, num_return_sequences=1)
        response = tokenizer.decode(output[0], skip_special_tokens=True)
        return response
    
    if __name__ == "__main__":
        print("ChatGPT: Hi! How can I assist you today?")
        while True:
            user_input = input("You: ")
            if user_input.lower() == "exit":
                print("ChatGPT: Goodbye!")
                break
            response = generate_response(user_input)
            print("ChatGPT:", response)
    
    print("ChatGPT: Hi! How can I assist you today?")
    while True:
        user_input = input("You: ")
        if user_input.lower() in ["exit", "quit"]:
            print("ChatGPT: Goodbye!")
            break
        response = generate_response(user_input)
        print("ChatGPT:", response)

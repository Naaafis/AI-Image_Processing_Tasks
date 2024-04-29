import os
import torch
from PIL import Image
from torchvision import transforms
from denoising_diffusion_pytorch import Unet, GaussianDiffusion

def load_and_denoise_image(image_path, model, device):
    img = Image.open(image_path).convert('RGB')
    transform = transforms.Compose([
        transforms.Resize((512, 512)),  # Adjust size as needed
        transforms.ToTensor()
    ])
    img = transform(img).unsqueeze(0)  # Add batch dimension
    img = img.to(device)  # Move to device

    # Assuming 'model' is a diffusion process that can be called directly on the image tensor
    denoised_img = model(img)
    return denoised_img.squeeze(0)  # Assuming the output needs to remove batch dimension

def save_image(tensor, image_path, output_subdir):
    img = transforms.ToPILImage()(tensor.cpu())  # Ensure tensor is moved to CPU
    base_name = os.path.basename(image_path)
    file_name, _ = os.path.splitext(base_name)
    output_image_path = os.path.join(output_subdir, f"{file_name}.png")
    img.save(output_image_path)

device = 'cuda' if torch.cuda.is_available() else 'cpu'
model = Unet(
    dim = 64,
    dim_mults = (1, 2, 4, 8)
).to(device)
diffusion = GaussianDiffusion(
    model,
    image_size = 512,
    timesteps = 1000  # Correct according to actual parameter requirements
).to(device)

main_directory = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/noised_images"
output_directory = "/Users/cheffbcookin/Desktop/EC520/AI-Image_Processing_Tasks/denoised_images_diffusion"
os.makedirs(output_directory, exist_ok=True)

for subdir in os.listdir(main_directory):
    subdir_path = os.path.join(main_directory, subdir)
    output_subdir = os.path.join(output_directory, subdir)
    os.makedirs(output_subdir, exist_ok=True)
    if os.path.isdir(subdir_path):
        for image_file in os.listdir(subdir_path):
            image_path = os.path.join(subdir_path, image_file)
            if image_file.lower().endswith(('.png', '.tif', '.tiff')):
                denoised_image = load_and_denoise_image(image_path, diffusion, device)
                save_image(denoised_image, image_path, output_subdir)

print("Denoising complete for all images.")

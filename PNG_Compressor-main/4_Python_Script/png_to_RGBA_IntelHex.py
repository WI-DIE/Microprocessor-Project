from PIL import Image
from intelhex import IntelHex

def png_to_intel_hex(png_filepath, hex_filepath):
    # open PNG
    img = Image.open(png_filepath)
    
    # extract RGBA from png
    rgba_data = img.convert("RGBA").tobytes()
    
    # RGBA  -> Intel Hex
    ih = IntelHex()
    
    start_address = 0x50000000
    for offset, byte in enumerate(rgba_data):
        ih[start_address + offset] = byte
    
    # store as Intel Hex
    ih.write_hex_file(hex_filepath)
    print(f"Intel Hex file '{hex_filepath}' has been created.")

png_to_intel_hex('input.png', 'output.hex')
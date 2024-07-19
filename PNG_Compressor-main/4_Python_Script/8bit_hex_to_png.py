from PIL import Image
from intelhex 
# 값을 그대로 적용 -> 3:3:2 비율
def intel_hex_to_png(hex_filepath, png_filepath, width, height):
    # Intel Hex 파일 열기
    ih = IntelHex(hex_filepath)
    # RGBA 데이터 생성
    rgba_data = bytearray()
    for address in range(ih.minaddr(), ih.maxaddr() + 1):
        byte_value = ih[address]
        r = ((byte_value >> 5) & 0b111) << 5  
        g = ((byte_value >> 2) & 0b111) << 5  
        b = (byte_value & 0b11) << 6 
        rgba_data.extend([r, g, b, 255])
    # RGBA 데이터를 PNG 이미지로 변환
    img = Image.frombytes('RGBA', (width, height), bytes(rgba_data))
    # PNG 파일로 저장
    img.save(png_filepath)
    print(f"PNG file '{png_filepath}' has been created.")

# 값을 그대로 적용 -> 최대한 정보를 사용해서
def intel_hex_to_png2(hex_filepath, png_filepath, width, height):
    # Intel Hex 파일 열기
    ih = IntelHex(hex_filepath)
    # RGBA 데이터 생성
    rgba_data = bytearray()
    for address in range(ih.minaddr(), ih.maxaddr() + 1):
        byte_value = ih[address]
        r_o = ((byte_value >> 5) & 0b111)
        g_o = ((byte_value >> 2) & 0b111) 
        b_o = (byte_value & 0b11)
        r = (r_o<<5) | (r_o<<2) | (r_o>>1)
        g = (g_o<<5) | (g_o<<2) | (g_o>>1)
        b = (b_o<<6) | (b_o<<4) | (b_o<<2) | b_o
        rgba_data.extend([r, g, b, 255])
    # RGBA 데이터를 PNG 이미지로 변환
    img = Image.frombytes('RGBA', (width, height), bytes(rgba_data))
    # PNG 파일로 저장
    img.save(png_filepath)
    print(f"PNG file '{png_filepath}' has been created.")

# 예제 실행 코드
input_filename = input("input_hex (without extension): ")
intel_hex_to_png(input_filename+".hex", input_filename+".png", width=960, height=640)  
intel_hex_to_png2(input_filename+".hex", input_filename+"2.png", width=960, height=640) 


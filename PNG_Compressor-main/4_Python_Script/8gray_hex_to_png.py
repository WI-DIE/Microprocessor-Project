from intelhex import IntelHex
from PIL import Image

def intel_hex_to_png(hex_filepath, png_filepath, width, height):
    # Intel Hex 파일 열기
    ih = IntelHex(hex_filepath)
    
    # RGBA 데이터 생성
    rgba_data = bytearray()
    for address in range(ih.minaddr(), ih.maxaddr() + 1):
        byte_value = ih[address]
        # 각 바이트마다 RGBA 값을 채움 (R, G, B는 byte_value로, A는 최대값 255로 설정)
        rgba_data.extend([byte_value, byte_value, byte_value, 255])        
    
    # RGBA 데이터를 PNG 이미지로 변환
    img = Image.frombytes('RGBA', (width, height), bytes(rgba_data))
    
    # PNG 파일로 저장
    img.save(png_filepath)
    print(f"PNG file '{png_filepath}' has been created.")

def intel_hex_to_png2(hex_filepath, png_filepath, width, height):
    # Intel Hex 파일 열기
    ih = IntelHex(hex_filepath)
    
    # 그레이스케일 데이터 생성
    grayscale_data = bytearray()
    for address in range(ih.minaddr(), ih.maxaddr() + 1):
        byte_value = ih[address]
        grayscale_data.append(byte_value)  # 각 바이트마다 grayscale 값을 채움
    
    # 그레이스케일 데이터를 PNG 이미지로 변환
    img = Image.frombytes('L', (width, height), bytes(grayscale_data))
    
    # PNG 파일로 저장
    img.save(png_filepath)
    print(f"PNG file '{png_filepath}' has been created.")
    
# 예제 실행 코드
input_filename = input("input_hex (without extension): ")
intel_hex_to_png(input_filename+".hex", input_filename+".png", width=960, height=640)  
intel_hex_to_png2(input_filename+".hex", input_filename+"2.png", width=960, height=640) 


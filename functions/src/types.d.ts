declare module "wav-decoder" {
  interface DecodedData {
    sampleRate: number;
    channelData: Float32Array[];
  }

  interface WavDecoder {
    decode: {
      (buffer: Uint8Array): Promise<DecodedData>;
      sync(buffer: Uint8Array): DecodedData;
    };
  }

  const decoder: WavDecoder;
  export = decoder;
}

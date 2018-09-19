UnityReadbackFromShader

Basic way to read single integer -for now- from CG shaders.

Works by computing in fragment shader and applying that value to framebuffer, then unity can readback from this buffer

### Shader
```csharp
fixed4 frag (v2f i) : SV_Target
{
  return int2Fixed4( Fibonacci(30) );
}
```

### C# 
```csharp
// get result texture see:FramebufferReadback.cs
var tex = GetResultTexture();

// get single pixel
Color c = tex.GetPixel(0, 0);

int fib30 = ReadbackValue(c);
```

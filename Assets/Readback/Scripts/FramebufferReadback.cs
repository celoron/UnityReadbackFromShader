using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FramebufferReadback : MonoBehaviour
{

	public Shader shader;

	public Texture source;
	
	private Material _material;

	private RenderTexture _renderTexture;

	private void Awake()
	{
		CreateMaterial();
		CreateRenderTexture();
		
		
	}

	private void Update()
	{
		Graphics.Blit(source, _renderTexture, _material);
		
		Texture2D tex = new Texture2D(1, 1, TextureFormat.RGBA32, false);
		Rect rectReadPicture = new Rect(0, 0, 1, 1);
 
		RenderTexture.active = _renderTexture;
 
		// Read pixels
		tex.ReadPixels(rectReadPicture, 0, 0);
		tex.Apply();
 
		RenderTexture.active = null;

		Color c = tex.GetPixel(0, 0);
		ReadbackValue(c);
	}

	void ReadbackValue(Color c)
	{
		//Debug.Log(c);
		int a0 = (int)(c.r * 255);
		int a1 = (int)(c.g * 255);
		int a2 = (int)(c.b * 255);
		int a3 = (int)(c.a * 255);

		int value = a0 | (a1 << 8) | (a2 << 16) | (a3 << 24);
		Debug.Log(value);
	}

	void CreateMaterial()
	{
		_material = new Material(shader);
	}

	void CreateRenderTexture()
	{
		_renderTexture= new RenderTexture(1, 1, 24);
	}
}

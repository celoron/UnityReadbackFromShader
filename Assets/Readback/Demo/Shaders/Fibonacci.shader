Shader "Hidden/Fibonacci"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			
			int Fibonacci(int n){
			
			    int t1 = 0, t2 = 1, nextTerm = 0;
			    for (int i = 1; i <= n; ++i)
                {
                    nextTerm = t1 + t2;
                    t1 = t2;
                    t2 = nextTerm;
                }
                return t1;
			}
			
			fixed4 int2Fixed4(int a){
			    int a0 = a & 0xFF;
			    int a1 = (a >> 8) & 0xFF;
			    int a2 = (a >> 16) & 0xFF;
			    int a3 = (a >> 24) & 0xFF;
				return fixed4(a0/255.0, a1/255.0, a2/255.0, a3/255.0);
			}

			fixed4 frag (v2f i) : SV_Target
			{
				return int2Fixed4(Fibonacci(30) );
			}
			ENDCG
		}
	}
}

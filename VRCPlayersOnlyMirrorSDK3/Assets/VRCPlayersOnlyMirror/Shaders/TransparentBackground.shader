Shader "Mirror/TransparentBackground" {
Properties {
	[Enum(UnityEngine.Rendering.CullMode)] _CullMode("Cull Mode", Int) = 1
	[ToggleUI(MIRROR_ONLY)] _MirrorOnly("Mirror Only", Float) = 0
}

SubShader {
    Tags { "RenderType"="Opaque" "IgnoreProjector"="True" "Queue"="Geometry"}
	ColorMask RGBA
	Cull [_CullMode]

    Pass {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
 
            #include "UnityCG.cginc"

            struct appdata_t {
                float4 vertex : POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            fixed4 _Color;
			float _MirrorOnly;

            v2f vert (appdata_t v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                o.vertex = UnityObjectToClipPos(v.vertex);
				if (_MirrorOnly == 1 & (unity_CameraProjection[2][0] == 0.f || unity_CameraProjection[2][1] == 0.f)){
					o.vertex = -1;
				}
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                fixed4 col = _Color;
                return col;
            }
        ENDCG
    }
}
}
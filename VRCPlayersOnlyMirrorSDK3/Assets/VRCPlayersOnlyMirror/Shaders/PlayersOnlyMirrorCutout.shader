Shader "Mirror/VRCPlayersOnlyMirrorCutout"
{
    Properties
    { 
        _MainTex("Base (RGB)", 2D) = "white" {}
        [HideInInspector] _ReflectionTex0("", 2D) = "white" {}
        [HideInInspector] _ReflectionTex1("", 2D) = "white" {}
        [ToggleUI(HideBackground)] _HideBackground("Hide Background", Float) = 0
        [ToggleUI(IgnoreEffects)] _IgnoreEffects("Ignore Effects", Float) = 0
        //Stencils
        [Space(50)] _Stencil ("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilCompareAction ("Stencil Compare Function", int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Pass Operation", int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilFail ("Stencil Fail Operation", int) = 0
        [Enum(UnityEngine.Rendering.StencilOp)] _StencilZFail ("Stencil ZFail Operation", int) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255
    }
    SubShader
    {
        Tags{ "RenderType"="TransparentCutout" "Queue"="AlphaTest" "IgnoreProjector"="True"}
        ZWrite On
        AlphaToMask On
        LOD 100

        Stencil
        {
            Ref [_Stencil]
            Comp [_StencilCompareAction]
            Pass [_StencilOp]
            Fail [_StencilFail]
            ZFail [_StencilZFail]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            #include "UnityCG.cginc"
            #include "UnityInstancing.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _HideBackground;
            float _IgnoreEffects;

            sampler2D _ReflectionTex0;
            sampler2D _ReflectionTex1;

            struct appdata 
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;

                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 refl : TEXCOORD1;
                float4 pos : SV_POSITION;
                UNITY_VERTEX_OUTPUT_STEREO
            };

            struct Input {
                float2 _ReflectionTex0;
                float2 _ReflectionTex1;
            };

            v2f vert(appdata v)
            {
                v2f o;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.refl = ComputeNonStereoScreenPos(o.pos);

                return o;
            }

            half4 frag(v2f i) : SV_Target
            {
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
                half4 tex = tex2D(_MainTex, i.uv);
                half4 refl = unity_StereoEyeIndex == 0 ? tex2Dproj(_ReflectionTex0, UNITY_PROJ_COORD(i.refl)) : tex2Dproj(_ReflectionTex1, UNITY_PROJ_COORD(i.refl));

                // Hiding background
                if (_HideBackground) {
                    refl.a = refl.a > 0 ? 1 : 
                                    _IgnoreEffects != 1 && dot(refl.rgb, fixed3(1,1,1)) / 3 > 0.01 ? 1 : 0;
                    clip(refl.a);
                } else {
                    refl.a = 1;
                }

                refl *= tex;             
                return refl;
            }

            ENDCG
        }
    }
}

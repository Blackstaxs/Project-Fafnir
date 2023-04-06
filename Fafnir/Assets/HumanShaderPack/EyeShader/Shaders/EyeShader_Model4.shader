// Upgrade NOTE: upgraded instancing buffer 'RRF_HumanShadersEyeShadersEyeShader_Model4' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RRF_HumanShaders/EyeShaders/EyeShader_Model4"
{
	Properties
	{
		[NoScaleOffset][Header(Main Textures)]_RGBMask("RGBMask", 2D) = "white" {}
		[NoScaleOffset]_IrisExtraDetail("IrisExtraDetail", 2D) = "white" {}
		[NoScaleOffset]_Sclera_Normal("Sclera_Normal", 2D) = "bump" {}
		[NoScaleOffset]_Lens_Base_Normal("Lens_Base_Normal", 2D) = "bump" {}
		[Header(Color Customization)][Space(6)]_EyeBallColorGlossA("EyeBallColor-Gloss(A)", Color) = (1,1,1,0.853)
		_IrisBaseColor("IrisBaseColor", Color) = (0.4999702,0.5441177,0.4641004,1)
		_IrisExtraColorAmountA("IrisExtraColor-Amount(A)", Color) = (0.08088237,0.07573904,0.04698314,0.591)
		_EyeVeinColorAmountA("EyeVeinColor-Amount(A)", Color) = (0.375,0,0,0)
		_RingColorAmount("RingColor-Amount", Color) = (0,0,0,0)
		_LimbalEdge_Adjustment("LimbalEdge_Adjustment", Range( 0 , 1)) = 0
		_LimbalRingGloss("LimbalRingGloss", Range( 0 , 1)) = 0
		_ScleraBumpScale("ScleraBumpScale", Range( 0 , 1)) = 0
		_EyeSize("EyeSize", Range( 0 , 2)) = 1
		_IrisSize("IrisSize", Range( 0 , 10)) = 1
		_IrisRotationAnimation("IrisRotationAnimation", Range( -10 , 10)) = 0
		_LensGloss("LensGloss", Range( 0 , 1)) = 0.98
		_LensPush("LensPush", Range( 0 , 1)) = 0.64
		[Header(Metalness)]_LimbalRingMetalness("LimbalRingMetalness", Range( 0 , 1)) = 0
		_IrisPupilMetalness("IrisPupilMetalness", Range( 0 , 1)) = 0
		_EyeBallMetalness("EyeBallMetalness", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Caustic FX)]_CausticMask("CausticMask", 2D) = "white" {}
		_CausticPower("CausticPower", Range( 0.5 , 10)) = 17
		_CausticFX_inDarkness("CausticFX_inDarkness", Range( 0 , 2)) = 17
		[Header(Pupil Control)][Space(6)]_PupilColorEmissivenessA("PupilColor-Emissiveness(A)", Color) = (0,0,0,0)
		_IrisPupilBond("Iris-Pupil-Bond", Range( 0 , 0.1)) = 0.017
		_PupilTexture("PupilTexture", 2D) = "white" {}
		_CustomPupilSize("CustomPupilSize", Range( 0 , 1)) = 1
		_PupilAutoDilateFactor("PupilAutoDilateFactor", Range( 0 , 1)) = 0
		_PupilAffByLightDir("PupilAffByLightDir", Range( 0 , 1)) = 0
		[NoScaleOffset][Header(Parallax Control)]_ParallaxMask("ParallaxMask", 2D) = "black" {}
		_PushParallaxMask("PushParallaxMask", Range( 0 , 5)) = 1
		_PupilParallaxHeight("PupilParallaxHeight", Range( 0 , 8)) = 2.5
		_EyeShadingPower("EyeShadingPower", Range( 0.01 , 2)) = 0.5
		_MinimumGlow("MinimumGlow", Range( 0 , 1)) = 0.2
		_MicroScatterScale("MicroScatterScale", Range( 0 , 1)) = 0
		_Eyeball_microScatter("Eyeball_microScatter", Range( 0 , 5)) = 0
		_EmissiveAdjust("EmissiveAdjust", Range( 0 , 1)) = 0.85
		_FinalEmissive("FinalEmissive", Range( 0 , 5)) = 2
		_MasterXAdjust("MasterXAdjust", Float) = 0
		_MasterYAdjust("MasterYAdjust", Float) = 0
		_PupilXAdjustFactor("PupilXAdjustFactor", Float) = 1
		_PupilYAdjustFactor("PupilYAdjustFactor", Float) = 1
		_IrisXAdjustFactor("IrisXAdjustFactor", Float) = 1
		_IrisYAdjustFactor("IrisYAdjustFactor", Float) = 1
		_PupilParalaxFactor("PupilParalaxFactor", Range( -2 , 2)) = 0
		_causticAdjustfactor("causticAdjustfactor", Range( -1 , 1)) = 0
		_SubSurfaceFromDirectionalLight("SubSurfaceFromDirectionalLight", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "DisableBatching" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float3 viewDir;
			half ase_vertexTangentSign;
		};

		uniform float _MicroScatterScale;
		uniform sampler2D _RGBMask;
		uniform float _EyeSize;
		uniform float _MasterXAdjust;
		uniform float _MasterYAdjust;
		uniform float _LimbalEdge_Adjustment;
		uniform float _Eyeball_microScatter;
		uniform sampler2D _Sclera_Normal;
		uniform float _ScleraBumpScale;
		uniform sampler2D _Lens_Base_Normal;
		uniform float _LensPush;
		uniform float _EyeShadingPower;
		uniform sampler2D _PupilTexture;
		uniform float _PupilParalaxFactor;
		uniform sampler2D _ParallaxMask;
		uniform float _PushParallaxMask;
		uniform float _PupilParallaxHeight;
		uniform float _CustomPupilSize;
		uniform float _PupilAffByLightDir;
		uniform float _PupilAutoDilateFactor;
		uniform float _PupilXAdjustFactor;
		uniform float _PupilYAdjustFactor;
		uniform float4 _EyeBallColorGlossA;
		uniform float4 _EyeVeinColorAmountA;
		uniform float4 _RingColorAmount;
		uniform sampler2D _IrisExtraDetail;
		uniform float _IrisSize;
		uniform float _IrisPupilBond;
		uniform float _IrisXAdjustFactor;
		uniform float _IrisYAdjustFactor;
		uniform float _IrisRotationAnimation;
		uniform float4 _IrisExtraColorAmountA;
		uniform float4 _IrisBaseColor;
		uniform float _SubSurfaceFromDirectionalLight;
		uniform sampler2D _CausticMask;
		uniform float _causticAdjustfactor;
		uniform float _CausticPower;
		uniform float _CausticFX_inDarkness;
		uniform float4 _PupilColorEmissivenessA;
		uniform float _EmissiveAdjust;
		uniform float _FinalEmissive;
		uniform float _LimbalRingMetalness;
		uniform float _EyeBallMetalness;
		uniform float _IrisPupilMetalness;
		uniform float _LimbalRingGloss;
		uniform float _LensGloss;

		UNITY_INSTANCING_BUFFER_START(RRF_HumanShadersEyeShadersEyeShader_Model4)
			UNITY_DEFINE_INSTANCED_PROP(float, _MinimumGlow)
#define _MinimumGlow_arr RRF_HumanShadersEyeShadersEyeShader_Model4
		UNITY_INSTANCING_BUFFER_END(RRF_HumanShadersEyeShadersEyeShader_Model4)


		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.ase_vertexTangentSign = v.tangent.w;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_1 = (( _MicroScatterScale * 1000.0 )).xx;
			float2 uv_TexCoord3_g50 = i.uv_texcoord * temp_cast_1;
			float simplePerlin3D4_g50 = snoise( float3( uv_TexCoord3_g50 ,  0.0 ) );
			float2 appendResult6_g50 = (float2(simplePerlin3D4_g50 , simplePerlin3D4_g50));
			float4 appendResult572 = (float4(appendResult6_g50 , 1.0 , 0.0));
			float2 temp_cast_3 = (_EyeSize).xx;
			float2 temp_cast_4 = (( ( 1.0 - _EyeSize ) / 2.0 )).xx;
			float2 uv_TexCoord264 = i.uv_texcoord * temp_cast_3 + temp_cast_4;
			float2 eyeSizeUVs604 = uv_TexCoord264;
			float2 appendResult921 = (float2(_MasterXAdjust , _MasterYAdjust));
			float2 MasterUVAdjust923 = appendResult921;
			float2 temp_output_927_0 = ( eyeSizeUVs604 + MasterUVAdjust923 );
			float4 tex2DNode166 = tex2D( _RGBMask, temp_output_927_0 );
			float lerpResult706 = lerp( tex2DNode166.b , ( tex2DNode166.b - tex2DNode166.r ) , _LimbalEdge_Adjustment);
			float clampResult721 = clamp( lerpResult706 , 0.0 , 1.0 );
			float IrisPupil_MASK585 = clampResult721;
			float clampResult717 = clamp( ( ( 1.0 - IrisPupil_MASK585 ) * 0.1 ) , 0.0 , 1.0 );
			float4 temp_output_504_0 = ( appendResult572 * clampResult717 * _Eyeball_microScatter );
			float4 lerpResult502 = lerp( float4( float3(0,0,1) , 0.0 ) , appendResult572 , temp_output_504_0);
			float3 lerpResult139 = lerp( float3(0,0,1) , UnpackNormal( tex2D( _Lens_Base_Normal, eyeSizeUVs604 ) ) , _LensPush);
			float3 lerpResult569 = lerp( BlendNormals( lerpResult502.xyz , UnpackScaleNormal( tex2D( _Sclera_Normal, eyeSizeUVs604 ), _ScleraBumpScale ) ) , lerpResult139 , IrisPupil_MASK585);
			float3 NORMAL_OUTPUT640 = lerpResult569;
			o.Normal = NORMAL_OUTPUT640;
			float temp_output_861_0 = ( ( 1.0 - i.uv_texcoord.y ) * i.uv_texcoord.y );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = Unity_SafeNormalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 _Vector1 = float3(0.15,0.06,0.4);
			float fresnelNdotV866 = dot( ase_worldNormal, ase_worldlightDir );
			float fresnelNode866 = ( _Vector1.x + _Vector1.y * pow( 1.0 - fresnelNdotV866, _Vector1.z ) );
			float3 temp_cast_6 = (( pow( ( temp_output_861_0 + temp_output_861_0 + temp_output_861_0 + temp_output_861_0 ) , ( 25.0 * _EyeShadingPower ) ) * fresnelNode866 )).xxx;
			float temp_output_2_0_g51 = _EyeShadingPower;
			float temp_output_3_0_g51 = ( 1.0 - temp_output_2_0_g51 );
			float3 appendResult7_g51 = (float3(temp_output_3_0_g51 , temp_output_3_0_g51 , temp_output_3_0_g51));
			float3 eyeShading672 = ( ( temp_cast_6 * temp_output_2_0_g51 ) + appendResult7_g51 );
			float4 tex2DNode416 = tex2D( _ParallaxMask, ( i.uv_texcoord + MasterUVAdjust923 ) );
			float4 lerpResult418 = lerp( float4( 0,0,0,0 ) , tex2DNode416 , _PushParallaxMask);
			float PupilParallaxHeight574 = _PupilParallaxHeight;
			float2 paralaxOffset255 = ParallaxOffset( lerpResult418.r , PupilParallaxHeight574 , i.viewDir );
			float2 ParallaxPush_Vec2580 = paralaxOffset255;
			float3 temp_cast_9 = (i.ase_vertexTangentSign).xxx;
			float dotResult4_g44 = dot( ase_worldlightDir , temp_cast_9 );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float lerpResult968 = lerp( _CustomPupilSize , ( _CustomPupilSize * ( dotResult4_g44 - (-1.0 + (ase_lightColor.a - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) ) , _PupilAffByLightDir);
			float3 break690 = ase_lightColor.rgb;
			float temp_output_692_0 = ( ( break690.x + break690.y + break690.z ) / 3.0 );
			float LightPower912 = temp_output_692_0;
			float temp_output_913_0 = ( (-15.0 + (lerpResult968 - 0.0) * (-2.5 - -15.0) / (1.0 - 0.0)) * ( LightPower912 * (-3.0 + (_PupilAutoDilateFactor - 0.0) * (0.0 - -3.0) / (1.0 - 0.0)) ) );
			float2 temp_cast_10 = (temp_output_913_0).xx;
			float2 temp_cast_11 = (( ( 1.0 - temp_output_913_0 ) / 2.0 )).xx;
			float2 uv_TexCoord904 = i.uv_texcoord * temp_cast_10 + temp_cast_11;
			float2 appendResult918 = (float2(_PupilXAdjustFactor , _PupilYAdjustFactor));
			float4 clampResult905 = clamp( ( tex2D( _PupilTexture, ( ( ( _PupilParalaxFactor * ParallaxPush_Vec2580 ) + uv_TexCoord904 ) + ( appendResult918 * MasterUVAdjust923 ) ) ) + ( 1.0 - IrisPupil_MASK585 ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 PupilMaskArea625 = clampResult905;
			float Sclera_MASK591 = tex2DNode166.g;
			float clampResult719 = clamp( ( ( _EyeVeinColorAmountA.a * 1.5 ) * Sclera_MASK591 ) , 0.0 , 1.0 );
			float4 lerpResult177 = lerp( ( _EyeBallColorGlossA * ( 1.0 - IrisPupil_MASK585 ) ) , ( _EyeVeinColorAmountA * Sclera_MASK591 ) , clampResult719);
			float4 LimbalRing_Color619 = _RingColorAmount;
			float LimbalRing_MASK590 = tex2DNode166.r;
			float eyeLimbalRingPower612 = ( _RingColorAmount.a * LimbalRing_MASK590 );
			float4 lerpResult184 = lerp( lerpResult177 , LimbalRing_Color619 , eyeLimbalRingPower612);
			float lerpResult953 = lerp( _IrisSize , ( _IrisSize * (-200.0 + (temp_output_913_0 - -50.0) * (-5.0 - -200.0) / (30.0 - -50.0)) ) , _IrisPupilBond);
			float3 temp_cast_12 = (i.ase_vertexTangentSign).xxx;
			float dotResult4_g45 = dot( ase_worldlightDir , temp_cast_12 );
			float clampResult545 = clamp( ( ( temp_output_692_0 * ( dotResult4_g45 - (-1.0 + (ase_lightColor.a - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) ) * IrisPupil_MASK585 ) , 0.0 , 99.0 );
			float IrisPupilFactor577 = ( ( 100.0 - clampResult545 ) * _IrisPupilBond );
			float eyeSizing616 = ( ( lerpResult953 + _EyeSize + IrisPupilFactor577 ) * IrisPupil_MASK585 );
			float2 temp_cast_13 = (eyeSizing616).xx;
			float2 uv_TexCoord190 = i.uv_texcoord * temp_cast_13 + ( ( ParallaxPush_Vec2580 * float2( 0.15,0.15 ) ) + ( ( 1.0 - eyeSizing616 ) / 2.0 ) );
			float2 appendResult940 = (float2(_IrisXAdjustFactor , _IrisYAdjustFactor));
			float2 temp_output_942_0 = ( MasterUVAdjust923 * appendResult940 );
			float mulTime765 = _Time.y * _IrisRotationAnimation;
			float cos764 = cos( mulTime765 );
			float sin764 = sin( mulTime765 );
			float2 rotator764 = mul( ( uv_TexCoord190 + temp_output_942_0 ) - float2( 0.5,0.5 ) , float2x2( cos764 , -sin764 , sin764 , cos764 )) + float2( 0.5,0.5 );
			float4 BaseIrisColors809 = ( ( ( ( tex2D( _IrisExtraDetail, rotator764 ) * _IrisExtraColorAmountA ) * _IrisExtraColorAmountA.a ) * IrisPupil_MASK585 ) + ( IrisPupil_MASK585 * _IrisBaseColor ) );
			float4 temp_output_326_0 = ( PupilMaskArea625 * ( ( lerpResult184 * lerpResult184 ) + BaseIrisColors809 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float dotResult5_g47 = dot( ase_worldlightDir , ase_vertexNormal );
			float _MinimumGlow_Instance = UNITY_ACCESS_INSTANCED_PROP(_MinimumGlow_arr, _MinimumGlow);
			float4 temp_cast_14 = (_MinimumGlow_Instance).xxxx;
			float4 clampResult478 = clamp( ( ( 1.0 * dotResult5_g47 ) * PupilMaskArea625 ) , temp_cast_14 , float4( 1,1,1,0 ) );
			float4 transform3_g48 = mul(unity_ObjectToWorld,float4( 0,-3,1,0.78 ));
			float dotResult6_g48 = dot( float4( ase_worldNormal , 0.0 ) , transform3_g48 );
			float clampResult7_g48 = clamp( dotResult6_g48 , 0.0 , 1.0 );
			float4 transform2_g48 = mul(unity_ObjectToWorld,float4( 0,1.2,1,0.78 ));
			float dotResult5_g48 = dot( float4( ase_worldNormal , 0.0 ) , transform2_g48 );
			float clampResult8_g48 = clamp( dotResult5_g48 , 0.0 , 1.0 );
			float3 temp_cast_17 = (pow( ( clampResult7_g48 * clampResult8_g48 ) , _EyeShadingPower )).xxx;
			float temp_output_2_0_g49 = ( _EyeShadingPower * 0.5 );
			float temp_output_3_0_g49 = ( 1.0 - temp_output_2_0_g49 );
			float3 appendResult7_g49 = (float3(temp_output_3_0_g49 , temp_output_3_0_g49 , temp_output_3_0_g49));
			float4 lerpResult568 = lerp( ( temp_output_326_0 * ( clampResult478 * float4( ( ( temp_cast_17 * temp_output_2_0_g49 ) + appendResult7_g49 ) , 0.0 ) ) ) , LimbalRing_Color619 , eyeLimbalRingPower612);
			float4 temp_output_674_0 = ( float4( eyeShading672 , 0.0 ) * lerpResult568 );
			float fresnelNdotV727 = dot( ase_worldNormal, ase_worldlightDir );
			float fresnelNode727 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV727, 5.0 ) );
			float FresnelLight732 = ( 1.0 - fresnelNode727 );
			float4 SubSurfaceArea784 = lerpResult177;
			float4 clampResult794 = clamp( ( FresnelLight732 * SubSurfaceArea784 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float dotResult782 = dot( ase_worldlightDir , ase_worldNormal );
			float LightComponent779 = dotResult782;
			float4 clampResult795 = clamp( ( LightComponent779 * SubSurfaceArea784 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 lerpResult787 = lerp( temp_output_674_0 , ( ase_lightColor * ( clampResult794 + clampResult795 + temp_output_674_0 ) ) , _SubSurfaceFromDirectionalLight);
			o.Albedo = ( lerpResult787 * ase_lightColor ).rgb;
			float2 paralaxOffset411 = ParallaxOffset( tex2DNode416.r , ( PupilParallaxHeight574 * 0.03 ) , i.viewDir );
			float2 uv_TexCoord409 = i.uv_texcoord * float2( 0,0 ) + paralaxOffset411;
			float2 ParallaxOffset_Vec2583 = ( uv_TexCoord409 + MasterUVAdjust923 );
			float2 eyeLocalUV633 = ( temp_output_927_0 + ParallaxOffset_Vec2583 );
			float cos373 = cos( ase_worldlightDir.x );
			float sin373 = sin( ase_worldlightDir.x );
			float2 rotator373 = mul( ( ( temp_output_942_0 * _causticAdjustfactor ) + eyeLocalUV633 ) - float2( 0.5,0.5 ) , float2x2( cos373 , -sin373 , sin373 , cos373 )) + float2( 0.5,0.5 );
			float4 tex2DNode370 = tex2D( _CausticMask, rotator373 );
			float clampResult856 = clamp( ( ( FresnelLight732 + 0.5 ) * 1.25 ) , 0.0 , 1.0 );
			float4 lerpResult761 = lerp( ( BaseIrisColors809 + ( BaseIrisColors809 * tex2DNode370 * ( _CausticPower * clampResult856 ) ) ) , ( BaseIrisColors809 + ( BaseIrisColors809 * tex2DNode370 * _CausticPower ) ) , _CausticFX_inDarkness);
			float4 clampResult745 = clamp( lerpResult761 , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
			float4 caustEmissission827 = clampResult745;
			float causticInDark824 = _CausticFX_inDarkness;
			float4 BaseColoring814 = ( PupilMaskArea625 * _MinimumGlow_Instance * temp_output_326_0 );
			float4 clampResult521 = clamp( ( lerpResult568 + lerpResult568 + ( BaseColoring814 + ( clampResult745 * PupilMaskArea625 ) ) ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 temp_output_665_0 = ( _PupilColorEmissivenessA.a * ( 1.0 - PupilMaskArea625 ) );
			float4 lerpResult648 = lerp( clampResult521 , lerpResult568 , temp_output_665_0);
			float4 PreEmissive804 = lerpResult648;
			float4 PupilGlow833 = ( _PupilColorEmissivenessA * temp_output_665_0 );
			float4 lerpResult889 = lerp( SubSurfaceArea784 , ( ( ( ( caustEmissission827 * causticInDark824 ) + ( ase_lightColor * PreEmissive804 ) ) * PupilMaskArea625 ) + PupilGlow833 ) , _EmissiveAdjust);
			o.Emission = ( lerpResult889 * _FinalEmissive ).rgb;
			float clampResult661 = clamp( ( ( LimbalRing_MASK590 * _LimbalRingMetalness ) + ( _EyeBallMetalness * ( 1.0 - IrisPupil_MASK585 ) ) + ( IrisPupil_MASK585 * _IrisPupilMetalness ) ) , 0.0 , 1.0 );
			float METALNESS_OUTPUT663 = clampResult661;
			o.Metallic = METALNESS_OUTPUT663;
			float EyeBallGloss622 = _EyeBallColorGlossA.a;
			float lerpResult135 = lerp( EyeBallGloss622 , ( _LensGloss * IrisPupil_MASK585 ) , IrisPupil_MASK585);
			float4 microScatter608 = temp_output_504_0;
			float lerpResult525 = lerp( ( ( _LimbalRingGloss * LimbalRing_MASK590 ) + lerpResult135 ) , 0.0 , ( ( 1.0 - IrisPupil_MASK585 ) * microScatter608 ).x);
			float SMOOTHNESS_OUTPUT642 = lerpResult525;
			o.Smoothness = SMOOTHNESS_OUTPUT642;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack1.z = customInputData.ase_vertexTangentSign;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				surfIN.ase_vertexTangentSign = IN.customPack1.z;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=18912
0;556.6667;1908;769;3136.105;-1392.289;1.386332;True;True
Node;AmplifyShaderEditor.CommentaryNode;615;-3521.69,-824.9874;Inherit;False;2148.08;465.2037;Sizing;12;616;323;578;247;604;264;265;266;267;953;956;972;Sizing;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;267;-3459.916,-621.3807;Float;False;Property;_EyeSize;EyeSize;12;0;Create;True;0;0;0;False;0;False;1;0.93;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;922;-5556.042,-2391.497;Inherit;False;473.0703;241.1963;UV positional Adjust;3;919;920;921;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;266;-3135.178,-463.3427;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;265;-2909.588,-457.2141;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;920;-5506.042,-2265.301;Inherit;False;Property;_MasterYAdjust;MasterYAdjust;42;0;Create;True;0;0;0;False;0;False;0;-0.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;919;-5506.042,-2341.497;Inherit;False;Property;_MasterXAdjust;MasterXAdjust;41;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;921;-5249.972,-2304.023;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;264;-2715.254,-530.2677;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;-2.5,-2.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;604;-2419.218,-497.7717;Float;False;eyeSizeUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;923;-5028.785,-2263.199;Inherit;False;MasterUVAdjust;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;635;-3474.641,-314.61;Inherit;False;1296.923;486.1872;Eye Local UV setup and RGB masking for Sclera, Limbal Ring and Iris Area;12;633;410;590;584;166;605;705;706;707;721;591;927;RGB Mixer map;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;605;-3578.159,-237.1042;Inherit;False;604;eyeSizeUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;926;-3579.638,-140.223;Inherit;False;923;MasterUVAdjust;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;927;-3322.763,-192.4687;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;166;-3081.737,-257.9168;Inherit;True;Property;_RGBMask;RGBMask;0;1;[NoScaleOffset];Create;True;0;0;0;False;1;Header(Main Textures);False;-1;d0431c3a16ed8b54c8d648bb79ca09a5;ea1c686f188c8ef46b8c015f1c344441;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;693;-6657.773,-1941.334;Inherit;False;889.9717;218.2189;Comment;4;685;690;691;692;GetLightColorIntensity;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;705;-2683.987,-49.25137;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;685;-6625.374,-1893.515;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;707;-2990.846,75.49301;Float;False;Property;_LimbalEdge_Adjustment;LimbalEdge_Adjustment;9;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;690;-6441.943,-1882.795;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;706;-2523.563,-58.65071;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;691;-6151.062,-1889.845;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;721;-2309.206,6.238053;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;662;-2148.269,-314.4674;Inherit;False;1320.225;575.4196;Make Metalness;11;723;722;585;657;655;656;660;661;663;724;725;Metalness;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;631;-5732.188,-1686.254;Inherit;False;1277.707;559.7808;PupilControl;4;587;555;901;967;Pupil Control;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;694;-6312.691,-1628.457;Inherit;False;PupilAffectedByLight_float;-1;;45;676c5e5a2752c454fab10b64fa534af1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;967;-4865.677,-1235.61;Inherit;False;PupilAffectedByLight_float;-1;;44;676c5e5a2752c454fab10b64fa534af1;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;901;-4841.709,-1313.309;Float;False;Property;_CustomPupilSize;CustomPupilSize;26;0;Create;True;0;0;0;False;0;False;1;0.745;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;692;-5920.385,-1873.472;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;585;-2113.652,59.17068;Float;False;IrisPupil_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;912;-5303.07,-1876.783;Inherit;False;LightPower;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;969;-4556.9,-1225.837;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;587;-5682.188,-1524.082;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;686;-5616.979,-1802.135;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;543;-4667.388,-1041.003;Float;False;Property;_PupilAutoDilateFactor;PupilAutoDilateFactor;27;0;Create;True;0;0;0;False;0;False;0;0.509;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;970;-4822.9,-1141.837;Inherit;False;Property;_PupilAffByLightDir;PupilAffByLightDir;28;0;Create;True;0;0;0;False;0;False;0;0.365;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;164;-4272.371,-1608.659;Inherit;False;3085.553;637.4598;Pupil;26;625;286;285;600;577;327;151;328;545;896;902;903;904;905;908;913;914;909;915;916;917;918;943;958;959;965;Pupil Control - UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;968;-4383.9,-1234.837;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;966;-4271.213,-1033.403;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-3;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;914;-4125.847,-1133.38;Inherit;False;912;LightPower;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;555;-5227.093,-1567.955;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;545;-4191.509,-1510.756;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;99;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;965;-3861.74,-1284.667;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-15;False;4;FLOAT;-2.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;943;-3879.676,-1088.271;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;151;-3987.563,-1500.814;Inherit;False;2;0;FLOAT;100;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;913;-3500.099,-1290.949;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;328;-4232.978,-1364.613;Float;False;Property;_IrisPupilBond;Iris-Pupil-Bond;24;0;Create;True;0;0;0;False;0;False;0.017;0.0139;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;327;-3837.603,-1408.009;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;247;-3494.194,-772.5389;Float;False;Property;_IrisSize;IrisSize;13;0;Create;True;0;0;0;False;0;False;1;3.19;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;957;-3678.904,-987.3154;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-50;False;2;FLOAT;30;False;3;FLOAT;-200;False;4;FLOAT;-5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;956;-3123.522,-684.3573;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;632;-5718.911,-1080.675;Inherit;False;733.9878;169.0557;ParallaxHeight Variable;2;257;574;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;935;-6314.583,-895.1539;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;577;-3636.844,-1412.601;Float;False;IrisPupilFactor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;934;-6312.965,-754.2917;Inherit;False;923;MasterUVAdjust;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;579;-5723.329,-855.0426;Inherit;False;2130.722;818.1102;Eye-Pupil/Iris Parallax;14;583;409;411;414;412;575;580;255;576;418;256;419;416;931;Parallax;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;578;-2417.713,-588.0516;Inherit;False;577;IrisPupilFactor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;-5668.911,-1030.676;Float;False;Property;_PupilParallaxHeight;PupilParallaxHeight;31;0;Create;True;0;0;0;False;0;False;2.5;1.56;0;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;953;-2932.194,-753.8951;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;936;-5944.965,-825.2917;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;323;-2141.998,-700.5798;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;419;-4996.699,-631.905;Float;False;Property;_PushParallaxMask;PushParallaxMask;30;0;Create;True;0;0;0;False;0;False;1;0.42;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;972;-2150.303,-558.7687;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;574;-5266.923,-1026.62;Float;False;PupilParallaxHeight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;416;-5673.329,-785.6605;Inherit;True;Property;_ParallaxMask;ParallaxMask;29;1;[NoScaleOffset];Create;True;0;0;0;False;1;Header(Parallax Control);False;-1;None;451268057d3fa344e8695ec36ec39129;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;418;-4636.011,-805.0426;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;256;-4611.694,-510.8292;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;576;-4634.585,-613.153;Inherit;False;574;PupilParallaxHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;971;-1887.703,-601.6688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;168;-3832.395,582.1473;Inherit;False;1825.509;996.859;Inputs;20;622;594;619;612;595;133;261;593;182;589;765;767;190;618;283;250;284;249;581;617;Color Inputs;1,1,1,1;0;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;255;-4327.307,-748.9097;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-1614.072,-706.6902;Float;False;eyeSizing;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;580;-4051.103,-752.9921;Float;False;ParallaxPush_Vec2;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;617;-3765.232,1334.682;Inherit;False;616;eyeSizing;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;581;-3550.232,1233.172;Inherit;False;580;ParallaxPush_Vec2;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;575;-5597.397,-369.1516;Inherit;False;574;PupilParallaxHeight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;946;-2852.408,1659.412;Inherit;False;682.1338;319.6736;Extra Feature adjustment;5;939;938;940;933;942;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;249;-3493.718,1337.928;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;250;-3205.079,1330.237;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;412;-5246.854,-223.3449;Float;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;414;-5227.638,-363.4906;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;284;-3221.494,1237.321;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.15,0.15;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;938;-2785.274,1787.085;Inherit;False;Property;_IrisXAdjustFactor;IrisXAdjustFactor;45;0;Create;True;0;0;0;False;0;False;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;939;-2785.274,1864.085;Inherit;False;Property;_IrisYAdjustFactor;IrisYAdjustFactor;46;0;Create;True;0;0;0;False;0;False;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;618;-2927.276,1196.944;Inherit;False;616;eyeSizing;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;283;-2945.854,1297.688;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;933;-2802.408,1709.412;Inherit;False;923;MasterUVAdjust;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxOffsetHlpNode;411;-4934.433,-304.0608;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;940;-2528.274,1827.085;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;190;-2373.319,1229.682;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;-2.5,-2.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;767;-2727.793,1097.685;Float;False;Property;_IrisRotationAnimation;IrisRotationAnimation;14;0;Create;True;0;0;0;False;0;False;0;0;-10;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;931;-4639.095,-204.9686;Inherit;False;923;MasterUVAdjust;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;942;-2339.274,1782.085;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;409;-4628.915,-351.2112;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;930;-4377.975,-253.7494;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;932;-2085.059,1289.211;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;902;-3383.389,-1158.163;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;765;-2351.253,1107.652;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;731;3123.164,2083.213;Inherit;False;1280.288;387.6746;Improved Light Falloff with inverse Fresnel and Light Dir;4;732;730;727;728;Light falloff simple;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;916;-3018.992,-1182.242;Inherit;False;Property;_PupilXAdjustFactor;PupilXAdjustFactor;43;0;Create;True;0;0;0;False;0;False;1;14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;903;-3201.07,-1145.333;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;728;3173.164,2155.734;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;959;-3249.287,-1547.853;Inherit;False;Property;_PupilParalaxFactor;PupilParalaxFactor;47;0;Create;True;0;0;0;False;0;False;0;0.52;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;583;-4128.254,-357.8154;Float;False;ParallaxOffset_Vec2;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;218;-1952.744,598.4021;Inherit;False;1171.74;940.1422;IrisFunk;13;613;620;177;175;210;330;185;415;187;598;170;184;719;Iris mixing;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;909;-3301.116,-1457.439;Inherit;False;580;ParallaxPush_Vec2;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;764;-2118.478,1077.569;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;917;-3026.992,-1108.242;Inherit;False;Property;_PupilYAdjustFactor;PupilYAdjustFactor;44;0;Create;True;0;0;0;False;0;False;1;14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;187;-1915.38,1314.087;Float;False;Property;_IrisExtraColorAmountA;IrisExtraColor-Amount(A);6;0;Create;True;0;0;0;False;0;False;0.08088237,0.07573904,0.04698314,0.591;0.1564169,0.2581889,0.3490566,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;958;-2910.287,-1528.853;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;185;-1903.107,1108.585;Inherit;True;Property;_IrisExtraDetail;IrisExtraDetail;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;7b7c97e104d9817418725e17f5ca2659;e2d81eed3c8d580428baa06160f91a78;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;918;-2807.992,-1148.242;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;925;-3038.821,-928.9701;Inherit;False;923;MasterUVAdjust;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;590;-2606.34,-272.9257;Float;False;LimbalRing_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;591;-2598.692,-201.7008;Float;False;Sclera_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;727;3483.091,2133.213;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;904;-3075.447,-1337.353;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;6,6;False;1;FLOAT2;-2.5,-2.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;584;-3424.641,63.08065;Inherit;False;583;ParallaxOffset_Vec2;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;170;-1908.036,772.9764;Float;False;Property;_EyeVeinColorAmountA;EyeVeinColor-Amount(A);7;0;Create;True;0;0;0;False;0;False;0.375,0,0,0;0.4150943,0.01244791,0,0.6156863;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;929;-2599.8,-1063.053;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;415;-1600.302,890.2409;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;182;-3417.43,823.6976;Float;False;Property;_RingColorAmount;RingColor-Amount;8;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0.854902;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;730;3774.033,2132.466;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;908;-2782.733,-1364.456;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;410;-3143.635,-18.3141;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;169;-757.5884,665.5753;Inherit;False;2366.183;1252.259;Mixing;28;135;134;623;20;451;603;326;627;325;626;478;489;476;103;321;322;319;636;126;251;586;775;776;777;778;809;810;814;Extra Mixing;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;593;-3406.51,1006.378;Inherit;False;590;LimbalRing_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-1477.025,1234.005;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;589;-2864.632,691.246;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;598;-1920.4,962.3043;Inherit;False;591;Sclera_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;251;-456.2553,1311.411;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;2;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;586;-727.6842,1492.685;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;732;4044.787,2122.227;Float;False;FresnelLight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;219;-1716.819,1929.655;Inherit;False;2546.831;732.6423;IrisConeCaustics;21;376;373;50;334;370;634;737;745;750;757;759;760;761;762;781;782;779;763;811;824;856;Caustics;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;330;-1427.309,932.8994;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;633;-2953.703,-10.51019;Float;False;eyeLocalUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;600;-2411.386,-1087.092;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;126;-706.0718,1582.184;Float;False;Property;_IrisBaseColor;IrisBaseColor;5;0;Create;True;0;0;0;False;0;False;0.4999702,0.5441177,0.4641004,1;0.08619615,0.08939311,0.1226415,0.9372549;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;133;-3418.101,633.1917;Float;False;Property;_EyeBallColorGlossA;EyeBallColor-Gloss(A);4;0;Create;True;0;0;0;False;2;Header(Color Customization);Space(6);False;1,1,1,0.853;1,1,1,0.8666667;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;595;-2446.204,695.3149;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;915;-2626.942,-1215.652;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;261;-2990.515,965.6833;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;976;-2175.377,2054.262;Inherit;False;Property;_causticAdjustfactor;causticAdjustfactor;48;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;896;-2396.268,-1386.538;Inherit;True;Property;_PupilTexture;PupilTexture;25;0;Create;True;0;0;0;False;0;False;-1;None;adc43291791447b418b6eaf7feb495c0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;974;-1863.088,1968.326;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;719;-1268.518,930.5994;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;322;-282.0901,1335.033;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;594;-2220.49,630.9065;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-1506.27,780.9657;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;319;-268.5711,1451.92;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;737;-1067.431,2407.645;Inherit;False;732;FresnelLight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;619;-3107.881,821.9865;Float;False;LimbalRing_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;612;-2755.021,996.3271;Float;False;eyeLimbalRingPower;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;285;-2201.06,-1170.585;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;634;-1678.214,2090.699;Inherit;False;633;eyeLocalUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;620;-1315.666,713.5411;Inherit;False;619;LimbalRing_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;376;-1658.832,2193.938;Inherit;False;True;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;613;-1336.574,638.1853;Inherit;False;612;eyeLimbalRingPower;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;177;-1135.945,790.793;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;759;-803.2366,2391.976;Inherit;False;ConstantBiasScale;-1;;46;63208df05c83e8e49a48ffbdce2e43a0;0;3;3;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;286;-1963.98,-1285.294;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;321;-98.59876,1373.383;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;973;-1365.621,2025.66;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;809;137.0322,1370.998;Float;False;BaseIrisColors;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;184;-940.8968,678.6216;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;905;-1731.555,-1276.055;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;856;-495.0187,2376.763;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;373;-1195.611,2100.363;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-764.0728,2238.058;Float;False;Property;_CausticPower;CausticPower;21;0;Create;True;0;0;0;False;0;False;17;1.85;0.5;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;670;839.3718,2052.064;Inherit;False;2223.228;278.96;Final Mixing - Emissive;7;452;471;521;628;743;815;827;Final Mixing for Emissive;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;810;-113.5322,1155.883;Inherit;False;809;BaseIrisColors;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;811;-586.6219,1953.813;Inherit;False;809;BaseIrisColors;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;370;-650.2144,2062.136;Inherit;True;Property;_CausticMask;CausticMask;20;1;[NoScaleOffset];Create;True;0;0;0;False;1;Header(Caustic FX);False;-1;None;d9e87f40b033e4245bb68d58ff0930bc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;757;-153.9395,2331.472;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;625;-1532.604,-1288.529;Float;False;PupilMaskArea;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-711.0731,707.4684;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;636;621.0922,1793.227;Inherit;False;LightDirectionZone_float;-1;;47;ce816473eb2cf6d4e96d84f2ab098aa5;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;325;192.3898,1121.124;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;760;-27.14433,2196.143;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;626;347.6477,1229.792;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;628;875.7011,2241.544;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;334;-24.99918,2018.613;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;489;594.1643,1489.961;Float;False;InstancedProperty;_MinimumGlow;MinimumGlow;35;0;Create;True;0;0;0;False;0;False;0.2;0.421;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;326;809.9284,1364.676;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;763;158.206,1963.214;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;762;204.3723,2174.062;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;750;-326.8658,2509.578;Float;False;Property;_CausticFX_inDarkness;CausticFX_inDarkness;22;0;Create;True;0;0;0;False;0;False;17;0.882;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;475;-1716.052,2683.718;Inherit;False;2220.814;763.4307;Eye Shading - Created local shadows around the eye (fake AO);12;672;871;483;869;864;866;863;865;861;467;860;858;Eye Shading;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;476;1164.363,1806.311;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;627;795.5042,1280.395;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;638;1637.879,1474.012;Inherit;False;1022.617;442.3356;LocalShadowPass Extra limbal Ring effect;6;637;481;470;614;568;910;Shadow FX;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;451;1172.024,1472.768;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;652;2682.394,1397.634;Inherit;False;950.9968;628.9937;Final Outputs and Pupil Color control;13;648;643;664;665;647;666;668;667;650;673;674;832;833;Final Gather;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;478;1392.077,1657.579;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;637;1687.879,1711.533;Inherit;False;LocalShadowing;32;;48;cbbcb7bdaf1755b499ae374337e1f753;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;858;-1638.03,2748.46;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;761;440.1433,2096.835;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;814;1390.149,1505.289;Float;False;BaseColoring;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;650;2701.278,1917.861;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;860;-1304.169,2747.889;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;745;657.967,2126.984;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;481;1909.57,1587.456;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;505;-511.9602,-644.9;Inherit;False;1832.025;501.339;Fake Microscatter effect - May be replaced with a simple noise-normalmap in a newer version;11;502;572;504;503;608;669;499;588;713;715;717;Microscatter;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;667;2859.071,1863.319;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;467;-1570.481,3115.249;Float;False;Property;_EyeShadingPower;EyeShadingPower;34;0;Create;True;0;0;0;False;0;False;0.5;0.16;0.01;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;743;1523.932,2170.736;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;815;1458.395,2093.988;Inherit;False;814;BaseColoring;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;910;2055.471,1716.182;Inherit;False;619;LimbalRing_Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;614;1795.835,1810.744;Inherit;False;612;eyeLimbalRingPower;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;470;2139.102,1524.012;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;861;-1067.49,2753.318;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;863;-800.7488,2748.87;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;568;2384.62,1694.109;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-506.7211,-583.7661;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;452;2057.326,2164.549;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;871;-1576.091,3241.048;Float;False;Constant;_Vector1;Vector 1;38;0;Create;True;0;0;0;False;0;False;0.15,0.06,0.4;0.15,0.06,0.4;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;865;-1158.297,3003.131;Inherit;False;2;2;0;FLOAT;25;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;668;2732.629,1848.105;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;666;2805.619,1764.239;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;864;-539.245,2748.068;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;866;-1178.856,3202.184;Inherit;True;Standard;WorldNormal;LightDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;647;2707.268,1444.284;Float;False;Property;_PupilColorEmissivenessA;PupilColor-Emissiveness(A);23;0;Create;True;0;0;0;False;2;Header(Pupil Control);Space(6);False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;781;-1653.115,2468.666;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;471;2670.734,2118.573;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;713;-250.4354,-532.1979;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;665;3010.243,1717.121;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;782;-1278.697,2339.555;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;715;-87.53503,-401.5688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;521;2887.6,2102.064;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;669;-43.51121,-496.9287;Inherit;False;MicroScatterScale_vec2;36;;50;27afac86e902b3f4680f2698fbeab237;0;0;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;869;-183.0838,2840.006;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;848;3715.594,1390.391;Inherit;False;1443.159;515.8131;FinalEmissive;11;804;806;818;829;831;830;826;844;845;847;846;Final Emissive;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;827;929.7286,2075.794;Float;False;caustEmissission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;648;3441.668,1712.301;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;824;282.5758,2504.359;Float;False;causticInDark;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;850;3130.02,359.8283;Inherit;False;1881.934;962.7947;Comment;14;783;780;790;793;785;794;788;796;797;789;802;787;803;795;BestSubSurface Scatter for Eye Model 3;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;572;404.3301,-453.4742;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;779;-1100.572,2288.379;Float;False;LightComponent;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;499;353.9738,-222.3932;Float;False;Property;_Eyeball_microScatter;Eyeball_microScatter;38;0;Create;True;0;0;0;False;0;False;0;0.81;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;784;-955.7665,827.1627;Float;False;SubSurfaceArea;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;483;-13.7304,2848.903;Inherit;False;Lerp White To;-1;;51;047d7c189c36a62438973bad9d37b1c2;0;2;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;717;97.39243,-306.1013;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;672;254.5334,2852.739;Float;False;eyeShading;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;780;3180.02,606.7944;Inherit;False;779;LightComponent;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;831;4043.524,1535.406;Inherit;False;824;causticInDark;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;829;4028.655,1440.391;Inherit;False;827;caustEmissission;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;603;-734.5588,1055.458;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;783;3180.29,794.4534;Inherit;True;784;SubSurfaceArea;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;806;3771.776,1560.623;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;167;-560.9434,47.91427;Inherit;False;2142.244;468.7774;Normal Maps;9;331;602;139;333;607;141;138;140;606;Normal Maps;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;804;3765.594,1730.662;Float;False;PreEmissive;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;622;-3092.575,727.5042;Float;False;EyeBallGloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;790;3196.831,409.8283;Inherit;False;732;FresnelLight;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;504;816.5957,-357.6282;Inherit;False;3;3;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;639;1635.956,1088.942;Inherit;False;1461.426;267.9109;Protect Iris area from eyewhite micro scatter;5;642;527;611;609;610;Mask out Microscatter;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-753.7518,947.6635;Float;False;Property;_LensGloss;LensGloss;15;0;Create;True;0;0;0;False;0;False;0.98;0.852;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;785;3518.789,722.4212;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;503;373.7202,-606.47;Float;False;Constant;_FlatNormal;FlatNormal;31;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;724;-2111.768,155.1683;Float;False;Property;_IrisPupilMetalness;IrisPupilMetalness;18;0;Create;True;0;0;0;False;0;False;0;0.218;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;722;-2105.917,-106.2091;Float;False;Property;_EyeBallMetalness;EyeBallMetalness;19;0;Create;True;0;0;0;False;0;False;0;0.082;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;832;3186.553,1655.089;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;777;240.8759,934.0576;Inherit;False;590;LimbalRing_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;793;3519.296,515.304;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;818;4036.508,1640.483;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;673;3112.564,1438.569;Inherit;False;672;eyeShading;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;723;-2128.732,-215.2754;Float;False;Property;_LimbalRingMetalness;LimbalRingMetalness;17;0;Create;True;0;0;0;False;1;Header(Metalness);False;0;0.125;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;830;4327.083,1479.824;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;725;-1887.699,4.125536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;623;-351.8134,813.577;Inherit;False;622;EyeBallGloss;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;610;1663.956,1168.022;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;608;1064.798,-255.6428;Float;False;microScatter;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;606;-538.2026,188.7793;Inherit;False;604;eyeSizeUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;333;586.7011,158.6582;Float;False;Property;_ScleraBumpScale;ScleraBumpScale;11;0;Create;True;0;0;0;False;0;False;0;0.507;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;607;660.5301,82.57835;Inherit;False;604;eyeSizeUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-150.6111,980.5873;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;776;217.8759,859.0576;Float;False;Property;_LimbalRingGloss;LimbalRingGloss;10;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;674;3412.119,1426.145;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;826;4537.544,1572.856;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;135;80.12472,988.3787;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;795;3764.5,737.1391;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;-1763.756,67.64504;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;502;1123.114,-510.9321;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;611;1938.345,1179.715;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;844;4039.651,1791.205;Inherit;False;625;PupilMaskArea;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;656;-1683.046,-62.42888;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;138;-276.5837,165.2453;Inherit;True;Property;_Lens_Base_Normal;Lens_Base_Normal;3;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;8ee6d0418eaa08e40ad667b400177c1c;e575b95fc35e1be4c93f2b963878ec25;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;141;-276.5095,369.9954;Float;False;Property;_LensPush;LensPush;16;0;Create;True;0;0;0;False;0;False;0.64;0.347;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;655;-1801.268,-260.4674;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;778;519.8759,895.0576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;331;956.9222,93.24535;Inherit;True;Property;_Sclera_Normal;Sclera_Normal;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;97ac39d433ae05047abf79173f71d460;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;833;3404.886,1640.262;Float;False;PupilGlow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;794;3754.959,510.9361;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;609;1657.123,1258.416;Inherit;False;608;microScatter;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;140;198.0932,97.91426;Float;False;Constant;_Vector0;Vector 0;10;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;139;755.3265,321.9293;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;660;-1491.204,-109.2472;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;602;1156.075,388.4355;Inherit;False;585;IrisPupil_MASK;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;527;2256.172,1242.286;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;845;4771.337,1668.933;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;788;4060.938,721.3491;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;796;4054.557,513.0011;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.BlendNormalsNode;332;1668.206,90.51281;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;775;698.8759,941.0576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;847;4697.979,1781.792;Inherit;False;833;PupilGlow;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;894;5576.33,1729.3;Inherit;False;707.2163;329.385;SelfGlowEffect;4;890;892;889;893;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;671;2253.061,110.756;Inherit;False;809.7659;371.8926;Blend normals;2;640;569;Blends Normal maps;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;895;5649.144,1674.124;Inherit;True;784;SubSurfaceArea;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;789;3885.831,1021.573;Float;False;Property;_SubSurfaceFromDirectionalLight;SubSurfaceFromDirectionalLight;49;0;Create;True;0;0;0;False;0;False;0.5;0.404;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;525;2474.173,966.8337;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;661;-1288.506,19.15284;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;890;5640.33,1876.575;Inherit;False;Property;_EmissiveAdjust;EmissiveAdjust;39;0;Create;True;0;0;0;False;0;False;0.85;0.525;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;846;5004.753,1708.175;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;797;4316.654,628.1948;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;569;2476.724,223.1104;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;892;5641.757,1953.663;Inherit;False;Property;_FinalEmissive;FinalEmissive;40;0;Create;True;0;0;0;False;0;False;2;0.9;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;802;4524.5,1166.623;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;787;4517.122,869.8699;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;640;2799.827,160.756;Float;False;NORMAL_OUTPUT;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;663;-1083.006,-143.5471;Float;False;METALNESS_OUTPUT;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;889;5919.034,1779.3;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;642;2793.351,1160.468;Float;False;SMOOTHNESS_OUTPUT;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;641;5295.641,1523.715;Inherit;False;640;NORMAL_OUTPUT;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;664;3342.195,1860.429;Inherit;False;663;METALNESS_OUTPUT;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;893;6114.546,1816.515;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;803;4842.954,1036.472;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;643;3330.132,1925.106;Inherit;False;642;SMOOTHNESS_OUTPUT;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;6502.902,1550.51;Float;False;True;-1;2;;0;0;Standard;RRF_HumanShaders/EyeShaders/EyeShader_Model4;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;266;0;267;0
WireConnection;265;0;266;0
WireConnection;921;0;919;0
WireConnection;921;1;920;0
WireConnection;264;0;267;0
WireConnection;264;1;265;0
WireConnection;604;0;264;0
WireConnection;923;0;921;0
WireConnection;927;0;605;0
WireConnection;927;1;926;0
WireConnection;166;1;927;0
WireConnection;705;0;166;3
WireConnection;705;1;166;1
WireConnection;690;0;685;1
WireConnection;706;0;166;3
WireConnection;706;1;705;0
WireConnection;706;2;707;0
WireConnection;691;0;690;0
WireConnection;691;1;690;1
WireConnection;691;2;690;2
WireConnection;721;0;706;0
WireConnection;692;0;691;0
WireConnection;585;0;721;0
WireConnection;912;0;692;0
WireConnection;969;0;901;0
WireConnection;969;1;967;0
WireConnection;686;0;692;0
WireConnection;686;1;694;0
WireConnection;968;0;901;0
WireConnection;968;1;969;0
WireConnection;968;2;970;0
WireConnection;966;0;543;0
WireConnection;555;0;686;0
WireConnection;555;1;587;0
WireConnection;545;0;555;0
WireConnection;965;0;968;0
WireConnection;943;0;914;0
WireConnection;943;1;966;0
WireConnection;151;1;545;0
WireConnection;913;0;965;0
WireConnection;913;1;943;0
WireConnection;327;0;151;0
WireConnection;327;1;328;0
WireConnection;957;0;913;0
WireConnection;956;0;247;0
WireConnection;956;1;957;0
WireConnection;577;0;327;0
WireConnection;953;0;247;0
WireConnection;953;1;956;0
WireConnection;953;2;328;0
WireConnection;936;0;935;0
WireConnection;936;1;934;0
WireConnection;323;0;953;0
WireConnection;323;1;267;0
WireConnection;323;2;578;0
WireConnection;574;0;257;0
WireConnection;416;1;936;0
WireConnection;418;1;416;0
WireConnection;418;2;419;0
WireConnection;971;0;323;0
WireConnection;971;1;972;0
WireConnection;255;0;418;0
WireConnection;255;1;576;0
WireConnection;255;2;256;0
WireConnection;616;0;971;0
WireConnection;580;0;255;0
WireConnection;249;0;617;0
WireConnection;250;0;249;0
WireConnection;414;0;575;0
WireConnection;284;0;581;0
WireConnection;283;0;284;0
WireConnection;283;1;250;0
WireConnection;411;0;416;0
WireConnection;411;1;414;0
WireConnection;411;2;412;0
WireConnection;940;0;938;0
WireConnection;940;1;939;0
WireConnection;190;0;618;0
WireConnection;190;1;283;0
WireConnection;942;0;933;0
WireConnection;942;1;940;0
WireConnection;409;1;411;0
WireConnection;930;0;409;0
WireConnection;930;1;931;0
WireConnection;932;0;190;0
WireConnection;932;1;942;0
WireConnection;902;0;913;0
WireConnection;765;0;767;0
WireConnection;903;0;902;0
WireConnection;583;0;930;0
WireConnection;764;0;932;0
WireConnection;764;2;765;0
WireConnection;958;0;959;0
WireConnection;958;1;909;0
WireConnection;185;1;764;0
WireConnection;918;0;916;0
WireConnection;918;1;917;0
WireConnection;590;0;166;1
WireConnection;591;0;166;2
WireConnection;727;4;728;0
WireConnection;904;0;913;0
WireConnection;904;1;903;0
WireConnection;929;0;918;0
WireConnection;929;1;925;0
WireConnection;415;0;170;4
WireConnection;730;0;727;0
WireConnection;908;0;958;0
WireConnection;908;1;904;0
WireConnection;410;0;927;0
WireConnection;410;1;584;0
WireConnection;210;0;185;0
WireConnection;210;1;187;0
WireConnection;251;0;210;0
WireConnection;251;1;187;4
WireConnection;732;0;730;0
WireConnection;330;0;415;0
WireConnection;330;1;598;0
WireConnection;633;0;410;0
WireConnection;595;0;589;0
WireConnection;915;0;908;0
WireConnection;915;1;929;0
WireConnection;261;0;182;4
WireConnection;261;1;593;0
WireConnection;896;1;915;0
WireConnection;974;0;942;0
WireConnection;974;1;976;0
WireConnection;719;0;330;0
WireConnection;322;0;251;0
WireConnection;322;1;586;0
WireConnection;594;0;133;0
WireConnection;594;1;595;0
WireConnection;175;0;170;0
WireConnection;175;1;598;0
WireConnection;319;0;586;0
WireConnection;319;1;126;0
WireConnection;619;0;182;0
WireConnection;612;0;261;0
WireConnection;285;0;600;0
WireConnection;177;0;594;0
WireConnection;177;1;175;0
WireConnection;177;2;719;0
WireConnection;759;3;737;0
WireConnection;286;0;896;0
WireConnection;286;1;285;0
WireConnection;321;0;322;0
WireConnection;321;1;319;0
WireConnection;973;0;974;0
WireConnection;973;1;634;0
WireConnection;809;0;321;0
WireConnection;184;0;177;0
WireConnection;184;1;620;0
WireConnection;184;2;613;0
WireConnection;905;0;286;0
WireConnection;856;0;759;0
WireConnection;373;0;973;0
WireConnection;373;2;376;1
WireConnection;370;1;373;0
WireConnection;757;0;50;0
WireConnection;757;1;856;0
WireConnection;625;0;905;0
WireConnection;103;0;184;0
WireConnection;103;1;184;0
WireConnection;325;0;103;0
WireConnection;325;1;810;0
WireConnection;760;0;811;0
WireConnection;760;1;370;0
WireConnection;760;2;50;0
WireConnection;334;0;811;0
WireConnection;334;1;370;0
WireConnection;334;2;757;0
WireConnection;326;0;626;0
WireConnection;326;1;325;0
WireConnection;763;0;811;0
WireConnection;763;1;334;0
WireConnection;762;0;811;0
WireConnection;762;1;760;0
WireConnection;476;0;636;0
WireConnection;476;1;628;0
WireConnection;451;0;627;0
WireConnection;451;1;489;0
WireConnection;451;2;326;0
WireConnection;478;0;476;0
WireConnection;478;1;489;0
WireConnection;761;0;763;0
WireConnection;761;1;762;0
WireConnection;761;2;750;0
WireConnection;814;0;451;0
WireConnection;860;0;858;2
WireConnection;745;0;761;0
WireConnection;481;0;478;0
WireConnection;481;1;637;0
WireConnection;667;0;650;0
WireConnection;743;0;745;0
WireConnection;743;1;628;0
WireConnection;470;0;326;0
WireConnection;470;1;481;0
WireConnection;861;0;860;0
WireConnection;861;1;858;2
WireConnection;863;0;861;0
WireConnection;863;1;861;0
WireConnection;863;2;861;0
WireConnection;863;3;861;0
WireConnection;568;0;470;0
WireConnection;568;1;910;0
WireConnection;568;2;614;0
WireConnection;452;0;815;0
WireConnection;452;1;743;0
WireConnection;865;1;467;0
WireConnection;668;0;667;0
WireConnection;666;0;668;0
WireConnection;864;0;863;0
WireConnection;864;1;865;0
WireConnection;866;1;871;1
WireConnection;866;2;871;2
WireConnection;866;3;871;3
WireConnection;471;0;568;0
WireConnection;471;1;568;0
WireConnection;471;2;452;0
WireConnection;713;0;588;0
WireConnection;665;0;647;4
WireConnection;665;1;666;0
WireConnection;782;0;376;0
WireConnection;782;1;781;0
WireConnection;715;0;713;0
WireConnection;521;0;471;0
WireConnection;869;0;864;0
WireConnection;869;1;866;0
WireConnection;827;0;745;0
WireConnection;648;0;521;0
WireConnection;648;1;568;0
WireConnection;648;2;665;0
WireConnection;824;0;750;0
WireConnection;572;0;669;0
WireConnection;779;0;782;0
WireConnection;784;0;177;0
WireConnection;483;1;869;0
WireConnection;483;2;467;0
WireConnection;717;0;715;0
WireConnection;672;0;483;0
WireConnection;804;0;648;0
WireConnection;622;0;133;4
WireConnection;504;0;572;0
WireConnection;504;1;717;0
WireConnection;504;2;499;0
WireConnection;785;0;780;0
WireConnection;785;1;783;0
WireConnection;832;0;647;0
WireConnection;832;1;665;0
WireConnection;793;0;790;0
WireConnection;793;1;783;0
WireConnection;818;0;806;0
WireConnection;818;1;804;0
WireConnection;830;0;829;0
WireConnection;830;1;831;0
WireConnection;725;0;585;0
WireConnection;608;0;504;0
WireConnection;134;0;20;0
WireConnection;134;1;603;0
WireConnection;674;0;673;0
WireConnection;674;1;568;0
WireConnection;826;0;830;0
WireConnection;826;1;818;0
WireConnection;135;0;623;0
WireConnection;135;1;134;0
WireConnection;135;2;603;0
WireConnection;795;0;785;0
WireConnection;657;0;585;0
WireConnection;657;1;724;0
WireConnection;502;0;503;0
WireConnection;502;1;572;0
WireConnection;502;2;504;0
WireConnection;611;0;610;0
WireConnection;656;0;722;0
WireConnection;656;1;725;0
WireConnection;138;1;606;0
WireConnection;655;0;590;0
WireConnection;655;1;723;0
WireConnection;778;0;776;0
WireConnection;778;1;777;0
WireConnection;331;1;607;0
WireConnection;331;5;333;0
WireConnection;833;0;832;0
WireConnection;794;0;793;0
WireConnection;139;0;140;0
WireConnection;139;1;138;0
WireConnection;139;2;141;0
WireConnection;660;0;655;0
WireConnection;660;1;656;0
WireConnection;660;2;657;0
WireConnection;527;0;611;0
WireConnection;527;1;609;0
WireConnection;845;0;826;0
WireConnection;845;1;844;0
WireConnection;788;0;794;0
WireConnection;788;1;795;0
WireConnection;788;2;674;0
WireConnection;332;0;502;0
WireConnection;332;1;331;0
WireConnection;775;0;778;0
WireConnection;775;1;135;0
WireConnection;525;0;775;0
WireConnection;525;2;527;0
WireConnection;661;0;660;0
WireConnection;846;0;845;0
WireConnection;846;1;847;0
WireConnection;797;0;796;0
WireConnection;797;1;788;0
WireConnection;569;0;332;0
WireConnection;569;1;139;0
WireConnection;569;2;602;0
WireConnection;787;0;674;0
WireConnection;787;1;797;0
WireConnection;787;2;789;0
WireConnection;640;0;569;0
WireConnection;663;0;661;0
WireConnection;889;0;895;0
WireConnection;889;1;846;0
WireConnection;889;2;890;0
WireConnection;642;0;525;0
WireConnection;893;0;889;0
WireConnection;893;1;892;0
WireConnection;803;0;787;0
WireConnection;803;1;802;0
WireConnection;0;0;803;0
WireConnection;0;1;641;0
WireConnection;0;2;893;0
WireConnection;0;3;664;0
WireConnection;0;4;643;0
ASEEND*/
//CHKSM=50340B4B1F8D414602196730F2421F14471D6AA5
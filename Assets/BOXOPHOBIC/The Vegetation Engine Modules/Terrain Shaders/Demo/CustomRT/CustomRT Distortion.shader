// Made with Amplify Shader Editor v1.9.2.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Effects/CustomRT Distortion"
{
    Properties
    {
		[StyledBanner(CustomRT Distortion)]_BANNER("[ BANNER ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainTexture("Main Texture", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_FlowTexture("Flow Texture", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_FlowMask("Flow Mask", 2D) = "white" {}
		[Space(10)]_FlowDistortion("Flow Distortion", Float) = 0.1
		_FlowTilling("Flow Tilling", Float) = 1
		_FlowSpeed("Flow Speed", Float) = 0.1
		_MainPanning("Main Panning", Vector) = (0,0,0,0)

    }

	SubShader
	{
		LOD 0

		
		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
        Pass
        {
			Name "Custom RT Update"
            CGPROGRAM
            
            #include "UnityCustomRenderTexture.cginc"
            #pragma vertex ASECustomRenderTextureVertexShader
            #pragma fragment frag
            #pragma target 3.0
			#include "UnityShaderVariables.cginc"


			struct ase_appdata_customrendertexture
			{
				uint vertexID : SV_VertexID;
				
			};

			struct ase_v2f_customrendertexture
			{
				float4 vertex           : SV_POSITION;
				float3 localTexcoord    : TEXCOORD0;    // Texcoord local to the update zone (== globalTexcoord if no partial update zone is specified)
				float3 globalTexcoord   : TEXCOORD1;    // Texcoord relative to the complete custom texture
				uint primitiveID        : TEXCOORD2;    // Index of the update zone (correspond to the index in the updateZones of the Custom Texture)
				float3 direction        : TEXCOORD3;    // For cube textures, direction of the pixel being rendered in the cubemap
				
			};

			uniform float _BANNER;
			uniform sampler2D _MainTexture;
			uniform half2 _MainPanning;
			uniform sampler2D _FlowTexture;
			uniform float _FlowTilling;
			uniform float _FlowSpeed;
			uniform float _FlowDistortion;
			uniform sampler2D _FlowMask;


			ase_v2f_customrendertexture ASECustomRenderTextureVertexShader(ase_appdata_customrendertexture IN  )
			{
				ase_v2f_customrendertexture OUT;
				
			#if UNITY_UV_STARTS_AT_TOP
				const float2 vertexPositions[6] =
				{
					{ -1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{  1.0f, -1.0f },
					{  1.0f,  1.0f },
					{ -1.0f,  1.0f },
					{  1.0f, -1.0f }
				};

				const float2 texCoords[6] =
				{
					{ 0.0f, 0.0f },
					{ 0.0f, 1.0f },
					{ 1.0f, 1.0f },
					{ 1.0f, 0.0f },
					{ 0.0f, 0.0f },
					{ 1.0f, 1.0f }
				};
			#else
				const float2 vertexPositions[6] =
				{
					{  1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{ -1.0f,  1.0f },
					{ -1.0f, -1.0f },
					{  1.0f,  1.0f },
					{  1.0f, -1.0f }
				};

				const float2 texCoords[6] =
				{
					{ 1.0f, 1.0f },
					{ 0.0f, 0.0f },
					{ 0.0f, 1.0f },
					{ 0.0f, 0.0f },
					{ 1.0f, 1.0f },
					{ 1.0f, 0.0f }
				};
			#endif

				uint primitiveID = IN.vertexID / 6;
				uint vertexID = IN.vertexID % 6;
				float3 updateZoneCenter = CustomRenderTextureCenters[primitiveID].xyz;
				float3 updateZoneSize = CustomRenderTextureSizesAndRotations[primitiveID].xyz;
				float rotation = CustomRenderTextureSizesAndRotations[primitiveID].w * UNITY_PI / 180.0f;

			#if !UNITY_UV_STARTS_AT_TOP
				rotation = -rotation;
			#endif

				// Normalize rect if needed
				if (CustomRenderTextureUpdateSpace > 0.0) // Pixel space
				{
					// Normalize xy because we need it in clip space.
					updateZoneCenter.xy /= _CustomRenderTextureInfo.xy;
					updateZoneSize.xy /= _CustomRenderTextureInfo.xy;
				}
				else // normalized space
				{
					// Un-normalize depth because we need actual slice index for culling
					updateZoneCenter.z *= _CustomRenderTextureInfo.z;
					updateZoneSize.z *= _CustomRenderTextureInfo.z;
				}

				// Compute rotation

				// Compute quad vertex position
				float2 clipSpaceCenter = updateZoneCenter.xy * 2.0 - 1.0;
				float2 pos = vertexPositions[vertexID] * updateZoneSize.xy;
				pos = CustomRenderTextureRotate2D(pos, rotation);
				pos.x += clipSpaceCenter.x;
			#if UNITY_UV_STARTS_AT_TOP
				pos.y += clipSpaceCenter.y;
			#else
				pos.y -= clipSpaceCenter.y;
			#endif

				// For 3D texture, cull quads outside of the update zone
				// This is neeeded in additional to the preliminary minSlice/maxSlice done on the CPU because update zones can be disjointed.
				// ie: slices [1..5] and [10..15] for two differents zones so we need to cull out slices 0 and [6..9]
				if (CustomRenderTextureIs3D > 0.0)
				{
					int minSlice = (int)(updateZoneCenter.z - updateZoneSize.z * 0.5);
					int maxSlice = minSlice + (int)updateZoneSize.z;
					if (_CustomRenderTexture3DSlice < minSlice || _CustomRenderTexture3DSlice >= maxSlice)
					{
						pos.xy = float2(1000.0, 1000.0); // Vertex outside of ncs
					}
				}

				OUT.vertex = float4(pos, 0.0, 1.0);
				OUT.primitiveID = asuint(CustomRenderTexturePrimitiveIDs[primitiveID]);
				OUT.localTexcoord = float3(texCoords[vertexID], CustomRenderTexture3DTexcoordW);
				OUT.globalTexcoord = float3(pos.xy * 0.5 + 0.5, CustomRenderTexture3DTexcoordW);
			#if UNITY_UV_STARTS_AT_TOP
				OUT.globalTexcoord.y = 1.0 - OUT.globalTexcoord.y;
			#endif
				OUT.direction = CustomRenderTextureComputeCubeDirection(OUT.globalTexcoord.xy);

				return OUT;
			}

            float4 frag(ase_v2f_customrendertexture IN ) : COLOR
            {
				float4 finalColor;
				float mulTime7 = _Time.y * 0.1;
				half2 Coords38 = ( IN.localTexcoord.xy + ( _MainPanning * mulTime7 ) );
				float mulTime17 = _Time.y * 0.1;
				
                finalColor = tex2D( _MainTexture, ( Coords38 + ( ((tex2D( _FlowTexture, ( ( IN.localTexcoord.xy * _FlowTilling ) + ( _FlowSpeed * mulTime17 ) ) )).rg*2.0 + -1.0) * ( _FlowDistortion * 0.01 ) * tex2D( _FlowMask, Coords38 ).r ) ) );
				return finalColor;
            }
            ENDCG
		}
    }
	
	CustomEditor "TVEShaderHelperGUI"
	Fallback Off
}
/*ASEBEGIN
Version=19202
Node;AmplifyShaderEditor.SwizzleNode;8;-992,0;Inherit;False;FLOAT2;0;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;12;-768,0;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;2;False;2;FLOAT;-1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-256,0;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-512,128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2176,128;Inherit;False;Property;_FlowTilling;Flow Tilling;5;0;Create;True;0;0;0;False;0;False;1;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-1920,0;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1536,0;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-1920,256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;0,-128;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2176,256;Inherit;False;Property;_FlowSpeed;Flow Speed;6;0;Create;True;0;0;0;False;0;False;0.1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-768,192;Half;False;Constant;_Float1;Float 0;8;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;17;-2176,320;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;13;-2176,0;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;5;-2176,640;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-1792,640;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;34;-2176,768;Half;False;Property;_MainPanning;Main Panning;7;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1920,768;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;7;-2176,880;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-768,304;Inherit;False;38;Coords;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-768,-128;Inherit;False;38;Coords;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;768,-128;Float;False;True;-1;2;TVEShaderHelperGUI;0;2;BOXOPHOBIC/The Vegetation Engine/Effects/CustomRT Distortion;32120270d1b3a8746af2aca8bc749736;True;Custom RT Update;0;0;Custom RT Update;1;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;38;-1536,640;Half;False;Coords;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1280,0;Inherit;True;Property;_FlowTexture;Flow Texture;2;1;[NoScaleOffset];Create;True;0;0;0;False;1;StyledTextureSingleLine;False;-1;None;c2bc4a3e47225b546a8ba477ad6acc60;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;384,-128;Inherit;True;Property;_TextureSample0;Texture Sample 0;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;4;0,-384;Inherit;True;Property;_MainTexture;Main Texture;1;1;[NoScaleOffset];Create;True;0;0;0;False;1;StyledTextureSingleLine;False;None;5f2774acf0fcf3547be824d9d5feae66;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;29;-512,288;Inherit;True;Property;_FlowMask;Flow Mask;3;1;[NoScaleOffset];Create;True;0;0;0;False;1;StyledTextureSingleLine;False;-1;None;5f2774acf0fcf3547be824d9d5feae66;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;44;-2176,-512;Inherit;False;Property;_BANNER;[ BANNER ];0;0;Create;True;0;0;0;True;1;StyledBanner(CustomRT Distortion);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-768,128;Inherit;False;Property;_FlowDistortion;Flow Distortion;4;0;Create;True;0;0;0;False;1;Space(10);False;0.1;1;0;0;0;1;FLOAT;0
WireConnection;8;0;1;0
WireConnection;12;0;8;0
WireConnection;9;0;12;0
WireConnection;9;1;30;0
WireConnection;9;2;29;1
WireConnection;30;0;10;0
WireConnection;30;1;36;0
WireConnection;14;0;13;0
WireConnection;14;1;15;0
WireConnection;16;0;14;0
WireConnection;16;1;32;0
WireConnection;32;0;11;0
WireConnection;32;1;17;0
WireConnection;28;0;43;0
WireConnection;28;1;9;0
WireConnection;42;0;5;0
WireConnection;42;1;31;0
WireConnection;31;0;34;0
WireConnection;31;1;7;0
WireConnection;0;0;27;0
WireConnection;38;0;42;0
WireConnection;1;1;16;0
WireConnection;27;0;4;0
WireConnection;27;1;28;0
WireConnection;29;1;40;0
ASEEND*/
//CHKSM=7F3405C2BE8826D4ED99EB2296CAA9E3CCC1CF3F
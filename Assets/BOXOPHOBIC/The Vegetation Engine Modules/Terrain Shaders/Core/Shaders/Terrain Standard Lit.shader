// Made with Amplify Shader Editor v1.9.3.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Landscape/Terrain Standard Lit"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 1
		[HideInInspector]_IsIdentifier("_IsIdentifier", Float) = 0
		[HideInInspector]_IsCollected("_IsCollected", Float) = 0
		[HideInInspector]_IsCustomShader("_IsCustomShader", Float) = 0
		[HideInInspector]_IsShared("_IsShared", Float) = 0
		[HideInInspector]_HasEmissive("_HasEmissive", Float) = 0
		[HideInInspector]_HasGradient("_HasGradient", Float) = 0
		[HideInInspector]_HasOcclusion("_HasOcclusion", Float) = 0
		[HideInInspector]_VertexVariationMode("_VertexVariationMode", Float) = 0
		[StyledCategory(Render Settings, 5, 10)]_CategoryRender("[ Category Render ]", Float) = 1
		[StyledMessage(Info, Use the Render Maps Packed mode to optimize the terrain texture usage. Check the documentation for Albedo and Mask texture packing mode. , _RenderPacked, 1, 0, 10)]_MessageTerrainMasks("# Message Terrain Masks", Float) = 0
		[HideInInspector]_RenderMode("Render Mode", Float) = 0
		[Enum(Off,0,On,1)]_RenderDecals("Render Decals", Float) = 0
		[Enum(Off,0,On,1)]_RenderClip("Alpha Clipping", Float) = 0
		_AlphaClipValue("Alpha Treshold", Range( 0 , 1)) = 0.5
		[StyledCategory(Global Settings)]_CategoryGlobals("[ Category Globals ]", Float) = 1
		[StyledMessage(Info, Use the terrain layer Albedo Alpha as Global Color mask and the Specular Alpha as Global Color influence., 0, 10)]_MessageTerrainColors("# Message Terrain Colors", Float) = 0
		[StyledEnum(TVEColorsLayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerColorsValue("Layer Colors", Float) = 0
		[StyledEnum(TVEExtrasLayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledEnum(TVEVertexLayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerVertexValue("Layer Vertex", Float) = 0
		[StyledSpace(10)]_SpaceGlobalLayers("# Space Global Layers", Float) = 0
		_GlobalColors("Global Color", Range( 0 , 1)) = 1
		_GlobalAlpha("Global Alpha", Range( 0 , 1)) = 1
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
		_GlobalHeight("Global Height Offset", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceGlobalLocals("# Space Global Locals", Float) = 0
		_ColorsIntensityValue("Color Intensity", Range( 0 , 2)) = 1
		_OverlayProjectionValue("Overlay Projection", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceGlobalOptions("# Space Global Options", Float) = 0
		[StyledCategory(Terrain Settings)]_CategoryTerrain("[Category Terrain ]", Float) = 1
		[Enum(4 Layers,4,8 Layers,8,12 Layers,12,16 Layers,16)]_TerrainLayersMode("Terrain Layers", Float) = 4
		[Enum(Simple,0,Height,1)]_TerrainBlendMode("Terrain Blend", Float) = 1
		[Enum(Default,0,Packed,1)]_TerrainTexMode("Terrain Maps", Float) = 0
		[HDR][Space(10)]_TerrainColor("Terrain Color", Color) = (1,1,1,1)
		_TerrainNormalValue("Terrain Normal", Range( -8 , 8)) = 1
		_TerrainOcclusionValue("Terrain Occlusion", Range( 0 , 1)) = 1
		_TerrainSmoothnessValue("Terrain Smoothness", Range( 0 , 1)) = 1
		_TerrainHeightBlendValue("Terrain Height Blend", Range( 0 , 1)) = 0
		[StyledCategory(Layer Settings)]_CategoryLayers("[ Category Layers ]", Float) = 1
		[HideInInspector][StyledCategory(Input Settings, 5, 10)]_CategoryInputs("[ Category Inputs ]", Float) = 1
		[HideInInspector]_HolesTex("Holes Mask", 2D) = "white" {}
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode1("Layer 01 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode2("Layer 02 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode3("Layer 03 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode4("Layer 04 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode5("Layer 05 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode6("Layer 06 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode7("Layer 07 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode8("Layer 08 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode9("Layer 09 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode10("Layer 10 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode11("Layer 11 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode12("Layer 12 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode13("Layer 13 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode14("Layer 14 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode15("Layer 15 Sample", Float) = 10
		[Enum(Planar,10,Triplanar,20,Stochastic,30,Stochasitc Triplanar,40)]_LayerSampleMode16("Layer 16 Sample", Float) = 10
		[HideInInspector]_ControlTex1("Control 01", 2D) = "black" {}
		[HideInInspector]_ControlTex2("Control 02", 2D) = "black" {}
		[HideInInspector]_ControlTex3("Control 03", 2D) = "black" {}
		[HideInInspector]_ControlTex4("Control 04", 2D) = "black" {}
		[HideInInspector]_AlbedoTex1("Albedo 01", 2D) = "white" {}
		[HideInInspector]_AlbedoTex2("Albedo 02", 2D) = "white" {}
		[HideInInspector]_AlbedoTex3("Albedo 03", 2D) = "white" {}
		[HideInInspector]_AlbedoTex4("Albedo 04", 2D) = "white" {}
		[HideInInspector]_AlbedoTex5("Albedo 05", 2D) = "white" {}
		[HideInInspector]_AlbedoTex6("Albedo 06", 2D) = "white" {}
		[HideInInspector]_AlbedoTex7("Albedo 07", 2D) = "white" {}
		[HideInInspector]_AlbedoTex8("Albedo 08", 2D) = "white" {}
		[HideInInspector]_AlbedoTex9("Albedo 09", 2D) = "white" {}
		[HideInInspector]_AlbedoTex10("Albedo 10", 2D) = "white" {}
		[HideInInspector]_AlbedoTex11("Albedo 11", 2D) = "white" {}
		[HideInInspector]_AlbedoTex12("Albedo 12", 2D) = "white" {}
		[HideInInspector]_AlbedoTex13("Albedo 13", 2D) = "white" {}
		[HideInInspector]_AlbedoTex14("Albedo 14", 2D) = "white" {}
		[HideInInspector]_AlbedoTex15("Albedo 15", 2D) = "white" {}
		[HideInInspector]_AlbedoTex16("Albedo 16", 2D) = "white" {}
		[HideInInspector]_NormalTex1("Normal 01", 2D) = "gray" {}
		[HideInInspector]_NormalTex2("Normal 02", 2D) = "gray" {}
		[HideInInspector]_NormalTex3("Normal 03", 2D) = "gray" {}
		[HideInInspector]_NormalTex4("Normal 04", 2D) = "gray" {}
		[HideInInspector]_NormalTex5("Normal 05", 2D) = "gray" {}
		[HideInInspector]_NormalTex6("Normal 06", 2D) = "gray" {}
		[HideInInspector]_NormalTex7("Normal 07", 2D) = "gray" {}
		[HideInInspector]_NormalTex8("Normal 08", 2D) = "gray" {}
		[HideInInspector]_NormalTex13("Normal 13", 2D) = "gray" {}
		[HideInInspector]_NormalTex9("Normal 09", 2D) = "gray" {}
		[HideInInspector]_NormalTex10("Normal 10", 2D) = "gray" {}
		[HideInInspector]_NormalTex11("Normal 11", 2D) = "gray" {}
		[HideInInspector]_NormalTex12("Normal 12", 2D) = "gray" {}
		[HideInInspector]_NormalTex14("Normal 14", 2D) = "gray" {}
		[HideInInspector]_NormalTex15("Normal 15", 2D) = "gray" {}
		[HideInInspector]_NormalTex16("Normal 16", 2D) = "gray" {}
		[HideInInspector]_MaskTex1("Mask 01", 2D) = "white" {}
		[HideInInspector]_MaskTex2("Mask 02", 2D) = "white" {}
		[HideInInspector]_MaskTex3("Mask 03", 2D) = "white" {}
		[HideInInspector]_MaskTex4("Mask 04", 2D) = "white" {}
		[HideInInspector]_MaskTex5("Mask 05", 2D) = "white" {}
		[HideInInspector]_MaskTex6("Mask 06", 2D) = "white" {}
		[HideInInspector]_MaskTex7("Mask 07", 2D) = "white" {}
		[HideInInspector]_MaskTex8("Mask 08", 2D) = "white" {}
		[HideInInspector]_MaskTex9("Mask 09", 2D) = "white" {}
		[HideInInspector]_MaskTex10("Mask 10", 2D) = "white" {}
		[HideInInspector]_MaskTex11("Mask 11", 2D) = "white" {}
		[HideInInspector]_MaskTex12("Mask 12", 2D) = "white" {}
		[HideInInspector]_MaskTex13("Mask 13", 2D) = "white" {}
		[HideInInspector]_MaskTex14("Mask 14", 2D) = "white" {}
		[HideInInspector]_MaskTex15("Mask 15", 2D) = "white" {}
		[HideInInspector]_MaskTex16("Mask 16", 2D) = "white" {}
		[HideInInspector]_MaskMin1("Mask Min 01", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax1("Mask Max 01", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin2("Mask Min 02", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax2("Mask Max 02", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin3("Mask Min 03", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax3("Mask Max 03", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin4("Mask Min 04", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax4("Mask Max 04", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin5("Mask Min 05", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax5("Mask Max 05", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin6("Mask Min 06", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax6("Mask Max 06", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin7("Mask Min 07", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax7("Mask Max 07", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin8("Mask Min 08", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax8("Mask Max 08", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin9("Mask Min 09", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax9("Mask Max 09", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin10("Mask Min 10", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax10("Mask Max 10", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin11("Mask Min 11", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax11("Mask Max 11", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin12("Mask Min 12", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax12("Mask Max 12", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin13("Mask Min 13", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax13("Mask Max 13", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin14("Mask Min 14", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax14("Mask Max 14", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin15("Mask Min 15", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax15("Mask Max 15", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMin16("Mask Min 16", Vector) = (0,0,0,0)
		[HideInInspector]_MaskMax16("Mask Max 16", Vector) = (0,0,0,0)
		[HideInInspector]_Params1("Params 01", Vector) = (0,0,0,0)
		[HideInInspector]_Params2("Params 02", Vector) = (0,0,0,0)
		[HideInInspector]_Params3("Params 03", Vector) = (0,0,0,0)
		[HideInInspector]_Params4("Params 04", Vector) = (0,0,0,0)
		[HideInInspector]_Params5("Params 05", Vector) = (0,0,0,0)
		[HideInInspector]_Params6("Params 06", Vector) = (0,0,0,0)
		[HideInInspector]_Params7("Params 07", Vector) = (0,0,0,0)
		[HideInInspector]_Params8("Params 08", Vector) = (0,0,0,0)
		[HideInInspector]_Params9("Params 09", Vector) = (0,0,0,0)
		[HideInInspector]_Params10("Params 10", Vector) = (0,0,0,0)
		[HideInInspector]_Params11("Params 11", Vector) = (0,0,0,0)
		[HideInInspector]_Params12("Params 12", Vector) = (0,0,0,0)
		[HideInInspector]_Params13("Params 13", Vector) = (0,0,0,0)
		[HideInInspector]_Params14("Params 14", Vector) = (0,0,0,0)
		[HideInInspector]_Params15("Params 15", Vector) = (0,0,0,0)
		[HideInInspector]_Params16("Params 16", Vector) = (0,0,0,0)
		[HideInInspector]_Coords1("Coords 01", Vector) = (1,1,0,0)
		[HideInInspector]_Coords2("Coords 02", Vector) = (1,1,0,0)
		[HideInInspector]_Coords3("Coords 03", Vector) = (1,1,0,0)
		[HideInInspector]_Coords5("Coords 05", Vector) = (1,1,0,0)
		[HideInInspector]_Coords4("Coords 04", Vector) = (1,1,0,0)
		[HideInInspector]_Coords6("Coords 06", Vector) = (1,1,0,0)
		[HideInInspector]_Coords7("Coords 07", Vector) = (1,1,0,0)
		[HideInInspector]_Coords8("Coords 08", Vector) = (1,1,0,0)
		[HideInInspector]_Coords9("Coords 09", Vector) = (1,1,0,0)
		[HideInInspector]_Coords10("Coords 10", Vector) = (1,1,0,0)
		[HideInInspector]_Coords11("Coords 11", Vector) = (1,1,0,0)
		[HideInInspector]_Coords12("Coords 12", Vector) = (1,1,0,0)
		[HideInInspector]_Coords13("Coords 13", Vector) = (1,1,0,0)
		[HideInInspector]_Coords14("Coords 14", Vector) = (1,1,0,0)
		[HideInInspector]_Coords15("Coords 15", Vector) = (1,1,0,0)
		[HideInInspector]_Coords16("Coords 16", Vector) = (1,1,0,0)
		[HideInInspector]_Specular1("Specular 01", Color) = (0,0,0,0)
		[HideInInspector]_Specular2("Specular 02", Color) = (0,0,0,0)
		[HideInInspector]_Specular3("Specular 03", Color) = (0,0,0,0)
		[HideInInspector]_Specular4("Specular 04", Color) = (0,0,0,0)
		[HideInInspector]_Specular5("Specular 05", Color) = (0,0,0,0)
		[HideInInspector]_Specular6("Specular 06", Color) = (0,0,0,0)
		[HideInInspector]_Specular7("Specular 07", Color) = (0,0,0,0)
		[HideInInspector]_Specular8("Specular 08", Color) = (0,0,0,0)
		[HideInInspector]_Specular9("Specular 09", Color) = (0,0,0,0)
		[HideInInspector]_Specular10("Specular 10", Color) = (0,0,0,0)
		[HideInInspector]_Specular11("Specular 11", Color) = (0,0,0,0)
		[HideInInspector]_Specular12("Specular 12", Color) = (0,0,0,0)
		[HideInInspector]_Specular13("Specular 13", Color) = (0,0,0,0)
		[HideInInspector]_Specular14("Specular 14", Color) = (0,0,0,0)
		[HideInInspector]_Specular15("Specular 15", Color) = (0,0,0,0)
		[HideInInspector]_Specular16("Specular 16", Color) = (0,0,0,0)
		[StyledCategory(Emissive Settings)]_CategoryEmissive("[ Category Emissive ]", Float) = 1
		[StyledMessage(Info, Use the terrain layer Albedo Alpha as Emissive Mask and the Specular Color as Emissive Color multiplier., 0, 10)]_MessageTerrainEmissive("# Message Terrain Emissive", Float) = 0
		[Enum(Off,0,On,1)]_EmissiveMode("Emissive Mode", Float) = 0
		[Enum(None,0,Any,1,Baked,2,Realtime,3)]_EmissiveFlagMode("Emissive GI", Float) = 0
		[HDR][Space(10)]_EmissiveColor("Emissive Color", Color) = (0,0,0,0)
		[Enum(Nits,0,EV100,1)]_EmissiveIntensityMode("Emissive Power", Float) = 0
		_EmissiveIntensityValue("Emissive Power", Float) = 1
		_EmissivePhaseValue("Emissive Phase", Range( 0 , 1)) = 1
		_EmissiveExposureValue("Emissive Weight", Range( 0 , 1)) = 0.5
		[Space(10)][StyledToggle]_EmissiveAlbedoMode("Use Albedo as Color Multiplier", Float) = 0
		[HideInInspector]_emissive_intensity_value("_emissive_intensity_value", Float) = 1
		[StyledCategory(Motion Settings)]_CategoryMotion("[ Category Motion ]", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 1230
		[HideInInspector]_IsTerrainShader("_IsTerrainShader", Float) = 1

		[HideInInspector] _RenderQueueType("Render Queue Type", Float) = 1
		//[HideInInspector][ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		[HideInInspector][ToggleUI] _SupportDecals("Support Decals", Float) = 1.0
		[HideInInspector] _StencilRef("Stencil Ref", Int) = 0 // StencilUsage.Clear
		[HideInInspector] _StencilWriteMask("Stencil Write Mask", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefDepth("Stencil Ref Depth", Int) = 0 // Nothing
		[HideInInspector] _StencilWriteMaskDepth("Stencil Write Mask Depth", Int) = 8 // StencilUsage.TraceReflectionRay
		[HideInInspector] _StencilRefMV("Stencil Ref MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilWriteMaskMV("Stencil Write Mask MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilRefDistortionVec("Stencil Ref Distortion Vec", Int) = 4 				// DEPRECATED
		[HideInInspector] _StencilWriteMaskDistortionVec("Stencil Write Mask Distortion Vec", Int) = 4	// DEPRECATED
		[HideInInspector] _StencilWriteMaskGBuffer("Stencil Write Mask GBuffer", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefGBuffer("Stencil Ref GBuffer", Int) = 2 // StencilUsage.RequiresDeferredLighting
		[HideInInspector] _ZTestGBuffer("ZTest GBuffer", Int) = 4
		[HideInInspector][ToggleUI] _RequireSplitLighting("Require Split Lighting", Float) = 0
		[HideInInspector][ToggleUI] _ReceivesSSR("Receives SSR", Float) = 1
		[HideInInspector][ToggleUI] _ReceivesSSRTransparent("Receives SSR Transparent", Float) = 0
		[HideInInspector] _SurfaceType("Surface Type", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _SrcBlend("Src Blend", Float) = 1
		[HideInInspector] _DstBlend("Dst Blend", Float) = 0
		[HideInInspector] _AlphaSrcBlend("Alpha Src Blend", Float) = 1
		[HideInInspector] _AlphaDstBlend("Alpha Dst Blend", Float) = 0
		[HideInInspector][ToggleUI] _ZWrite("ZWrite", Float) = 1
		[HideInInspector][ToggleUI] _TransparentZWrite("Transparent ZWrite", Float) = 0
		[HideInInspector] _CullMode("Cull Mode", Float) = 2
		[HideInInspector] _TransparentSortPriority("Transparent Sort Priority", Float) = 0
		[HideInInspector][ToggleUI] _EnableFogOnTransparent("Enable Fog", Float) = 1
		[HideInInspector] _CullModeForward("Cull Mode Forward", Float) = 2 // This mode is dedicated to Forward to correctly handle backface then front face rendering thin transparent
		[HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.TransparentCullMode)] _TransparentCullMode("Transparent Cull Mode", Int) = 2 // Back culling by default
		[HideInInspector] _ZTestDepthEqualForOpaque("ZTest Depth Equal For Opaque", Int) = 4 // Less equal
		[HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)] _ZTestTransparent("ZTest Transparent", Int) = 4 // Less equal
		[HideInInspector][ToggleUI] _TransparentBackfaceEnable("Transparent Backface Enable", Float) = 0
		[HideInInspector][ToggleUI] _AlphaCutoffEnable("Alpha Cutoff Enable", Float) = 0
		[HideInInspector][ToggleUI] _UseShadowThreshold("Use Shadow Threshold", Float) = 0
		[HideInInspector][ToggleUI] _DoubleSidedEnable("Double Sided Enable", Float) = 0
		[HideInInspector][Enum(Flip, 0, Mirror, 1, None, 2)] _DoubleSidedNormalMode("Double Sided Normal Mode", Float) = 2
		[HideInInspector] _DoubleSidedConstants("DoubleSidedConstants", Vector) = (1,1,-1,0)

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleUI] _TransparentWritingMotionVec("Transparent Writing MotionVec", Float) = 0
		[HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.OpaqueCullMode)] _OpaqueCullMode("Opaque Cull Mode", Int) = 2 // Back culling by default
		[HideInInspector][ToggleUI] _EnableBlendModePreserveSpecularLighting("Enable Blend Mode Preserve Specular Lighting", Float) = 1
		[HideInInspector] _EmissionColor("Color", Color) = (1, 1, 1)

		[HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

		[HideInInspector][Enum(Auto, 0, On, 1, Off, 2)] _DoubleSidedGIMode("Double sided GI mode", Float) = 0

		[HideInInspector][ToggleUI] _AlphaToMaskInspectorValue("_AlphaToMaskInspectorValue", Float) = 0 // Property used to save the alpha to mask state in the inspector
        [HideInInspector][ToggleUI] _AlphaToMask("__alphaToMask", Float) = 0

		//_Refrac ( "Refraction Model", Float) = 0
        [HideInInspector][ToggleUI]_DepthOffsetEnable("Boolean", Float) = 1
        [HideInInspector][ToggleUI]_ConservativeDepthOffsetEnable("Boolean", Float) = 1
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Geometry" "TerrainCompatible"="True" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma exclude_renderers glcore gles gles3 

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		struct GlobalSurfaceDescription // GBuffer Forward META TransparentBackface
		{
			float3 BaseColor;
			float3 Normal;
			float3 BentNormal;
			float3 Specular;
			float CoatMask;
			float Metallic;
			float3 Emission;
			float Smoothness;
			float Occlusion;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPrepass;
			float AlphaClipThresholdDepthPostpass;
			float SpecularOcclusion;
			float SpecularAAScreenSpaceVariance;
			float SpecularAAThreshold;
			float RefractionIndex;
			float3 RefractionColor;
			float RefractionDistance;
			float DiffusionProfile;
			float TransmissionMask;
			float Thickness;
			float SubsurfaceMask;
			float Anisotropy;
			float3 Tangent;
			float IridescenceMask;
			float IridescenceThickness;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct AlphaSurfaceDescription // ShadowCaster
		{
			float3 Emission;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct SceneSurfaceDescription // SceneSelection
		{
		    float3 Emission;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float RefractionIndex;
			float3 RefractionColor;
			float RefractionDistance;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct PrePassSurfaceDescription // DepthPrePass
		{
			float3 Normal;
			float3 Emission;
			float Smoothness;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPrepass;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct PostPassSurfaceDescription //DepthPostPass
		{
			float3 Emission;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPostpass;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct SmoothSurfaceDescription // MotionVectors DepthOnly
		{
			float3 Normal;
			float3 Emission;
			float Smoothness;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

        struct PickingSurfaceDescription //Picking
		{
            float3 BentNormal;
			float3 Emission;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;

			float3 ObjectSpaceNormal;
			float3 WorldSpaceNormal;
			float3 TangentSpaceNormal;
			float3 ObjectSpaceViewDirection;
			float3 WorldSpaceViewDirection;
			float3 ObjectSpacePosition;
		};

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlaneASE (float3 pos, float4 plane)
		{
			return dot (float4(pos,1.0f), plane);
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlaneASE(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlaneASE(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlaneASE(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlaneASE(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="GBuffer" }

			Cull [_CullMode]
			ZTest [_ZTestGBuffer]

			Stencil
			{
				Ref [_StencilRefGBuffer]
				WriteMask [_StencilWriteMaskGBuffer]
				Comp Always
				Pass Replace
			}


			ColorMask [_LightLayersMaskBuffer4] 4
			ColorMask [_LightLayersMaskBuffer5] 5

			HLSLPROGRAM
            #pragma shader_feature_local _ _DOUBLESIDED_ON
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            #define ASE_ABSOLUTE_VERTEX_POS 1
            #pragma shader_feature_local_fragment _ _DISABLE_DECALS
            #define _AMBIENT_OCCLUSION 1
            #define HAVE_MESH_MODIFICATION
            #define ASE_SRP_VERSION 140011
            #define ASE_USING_SAMPLING_MACROS 1

            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma multi_compile_fragment _ LIGHT_LAYERS
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile _ DEBUG_DISPLAY
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile_fragment PROBE_VOLUMES_OFF PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
            #pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MaskMax8;
			half4 _Coords7;
			half4 _MaskMax6;
			half4 _MaskMin6;
			half4 _Coords6;
			half4 _MaskMax5;
			half4 _MaskMin5;
			half4 _Coords5;
			half4 _MaskMax4;
			half4 _MaskMin4;
			half4 _MaskMin7;
			half4 _Coords4;
			half4 _MaskMin3;
			half4 _Coords3;
			half4 _MaskMax2;
			half4 _MaskMin2;
			half4 _Coords2;
			half4 _MaskMax1;
			half4 _MaskMin1;
			half4 _Coords1;
			half4 _MaskMax16;
			half4 _MaskMax3;
			half4 _MaskMax7;
			half4 _Coords8;
			half4 _MaskMin8;
			half4 _MaskMin15;
			half4 _Coords15;
			half4 _MaskMax14;
			half4 _MaskMin14;
			half4 _Coords14;
			half4 _MaskMax13;
			half4 _MaskMin13;
			half4 _Coords13;
			half4 _MaskMax12;
			half4 _MaskMin12;
			half4 _Coords12;
			half4 _MaskMax11;
			half4 _MaskMin11;
			half4 _Coords11;
			half4 _MaskMax10;
			half4 _MaskMin10;
			half4 _Coords10;
			half4 _MaskMax9;
			half4 _MaskMin9;
			half4 _Coords9;
			half4 _MaskMin16;
			half4 _TerrainColor;
			half4 _MaskMax15;
			half4 _Coords16;
			half4 _Params5;
			half4 _Params2;
			half4 _Params3;
			half4 _Params4;
			half4 _Params6;
			half4 _Params7;
			half4 _Params8;
			half4 _Params1;
			half4 _Params9;
			half4 _Params11;
			half4 _Params12;
			half4 _Params13;
			half4 _Params14;
			half4 _Params15;
			half4 _Params16;
			half4 _Params10;
			half4 _Specular16;
			half4 _EmissiveColor;
			half4 _Specular7;
			half4 _Specular3;
			half4 _Specular4;
			half4 _Specular5;
			half4 _Specular6;
			half4 _Specular15;
			half4 _Specular8;
			half4 _Specular2;
			half4 _Specular9;
			half4 _Specular11;
			half4 _Specular12;
			half4 _Specular13;
			half4 _Specular14;
			half4 _Specular10;
			half4 _Specular1;
			half _EmissivePhaseValue;
			half _GlobalEmissive;
			half _TerrainSmoothnessValue;
			float _emissive_intensity_value;
			half _EmissiveAlbedoMode;
			half _TerrainOcclusionValue;
			half _EmissiveExposureValue;
			half _GlobalColors;
			half _OverlayProjectionValue;
			half _TerrainNormalValue;
			half _ColorsIntensityValue;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _TerrainHeightBlendValue;
			half _GlobalWetness;
			half _LayerColorsValue;
			half _CategoryGlobals;
			half _GlobalHeight;
			half _CategoryEmissive;
			half _CategoryMotion;
			half _EmissiveIntensityValue;
			half _EmissiveIntensityMode;
			half _EmissiveFlagMode;
			half _IsVersion;
			half _IsTerrainShader;
			half _CategoryRender;
			half _MessageTerrainEmissive;
			half _MessageTerrainColors;
			half _CategoryTerrain;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _IsCustomShader;
			half _IsShared;
			half _IsCollected;
			half _IsIdentifier;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceGlobalOptions;
			half _SpaceGlobalLocals;
			half _SpaceGlobalLayers;
			half _CategoryLayers;
			half _GlobalAlpha;
			half _TerrainLayersMode;
			half _TerrainBlendMode;
			half _LayerVertexValue;
			half _RenderClip;
			half _LayerSampleMode16;
			half _LayerSampleMode15;
			half _LayerSampleMode14;
			half _LayerSampleMode13;
			half _LayerSampleMode12;
			half _LayerSampleMode11;
			half _LayerSampleMode10;
			half _LayerSampleMode9;
			half _LayerSampleMode8;
			half _LayerSampleMode7;
			half _LayerSampleMode6;
			half _LayerSampleMode5;
			half _LayerSampleMode1;
			half _LayerSampleMode4;
			half _LayerSampleMode3;
			half _LayerSampleMode2;
			half _CategoryInputs;
			half _TerrainTexMode;
			half _RenderMode;
			half _RenderDecals;
			half _EmissiveMode;
			half _MessageTerrainMasks;
			half _AlphaClipValue;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(sampler_Linear_Clamp);
			half4 TVE_VertexParams;
			TEXTURE2D(_ControlTex1);
			SAMPLER(sampler_Linear_Clamp_Aniso8);
			TEXTURE2D(_ControlTex2);
			TEXTURE2D(_ControlTex3);
			TEXTURE2D(_ControlTex4);
			TEXTURE2D(_MaskTex1);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			TEXTURE2D(_MaskTex2);
			TEXTURE2D(_MaskTex3);
			TEXTURE2D(_MaskTex4);
			TEXTURE2D(_MaskTex5);
			TEXTURE2D(_MaskTex6);
			TEXTURE2D(_MaskTex7);
			TEXTURE2D(_MaskTex8);
			TEXTURE2D(_MaskTex9);
			TEXTURE2D(_MaskTex10);
			TEXTURE2D(_MaskTex11);
			TEXTURE2D(_MaskTex12);
			TEXTURE2D(_MaskTex13);
			TEXTURE2D(_MaskTex14);
			TEXTURE2D(_MaskTex15);
			TEXTURE2D(_MaskTex16);
			TEXTURE2D(_AlbedoTex1);
			TEXTURE2D(_AlbedoTex2);
			TEXTURE2D(_AlbedoTex3);
			TEXTURE2D(_AlbedoTex4);
			TEXTURE2D(_AlbedoTex5);
			TEXTURE2D(_AlbedoTex6);
			TEXTURE2D(_AlbedoTex7);
			TEXTURE2D(_AlbedoTex8);
			TEXTURE2D(_AlbedoTex9);
			TEXTURE2D(_AlbedoTex10);
			TEXTURE2D(_AlbedoTex11);
			TEXTURE2D(_AlbedoTex12);
			TEXTURE2D(_AlbedoTex13);
			TEXTURE2D(_AlbedoTex14);
			TEXTURE2D(_AlbedoTex15);
			TEXTURE2D(_AlbedoTex16);
			float TVE_ColorsUsage[10];
			TEXTURE2D_ARRAY(TVE_ColorsTex);
			half4 TVE_ColorsCoords;
			half4 TVE_ColorsParams;
			half TVE_IsEnabled;
			half4 TVE_OverlayColor;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			TEXTURE2D(_NormalTex1);
			TEXTURE2D(_NormalTex2);
			TEXTURE2D(_NormalTex3);
			TEXTURE2D(_NormalTex4);
			TEXTURE2D(_NormalTex5);
			TEXTURE2D(_NormalTex6);
			TEXTURE2D(_NormalTex7);
			TEXTURE2D(_NormalTex8);
			TEXTURE2D(_NormalTex9);
			TEXTURE2D(_NormalTex10);
			TEXTURE2D(_NormalTex11);
			TEXTURE2D(_NormalTex12);
			TEXTURE2D(_NormalTex13);
			TEXTURE2D(_NormalTex14);
			TEXTURE2D(_NormalTex15);
			TEXTURE2D(_NormalTex16);
			half TVE_WetnessContrast;
			half TVE_OverlayNormalValue;
			half TVE_WetnessNormalValue;
			half TVE_OverlaySmoothness;
			TEXTURE2D(_HolesTex);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_VERT_TANGENT
			#pragma shader_feature_local_fragment TVE_ALPHA_CLIP
			#pragma shader_feature_local_fragment TVE_TERRAIN_04 TVE_TERRAIN_08 TVE_TERRAIN_12 TVE_TERRAIN_16
			#pragma shader_feature_local_fragment TVE_HEIGHT_BLEND
			#pragma shader_feature_local_fragment TVE_SAMPLE_01_PLANAR_2D TVE_SAMPLE_01_PLANAR_3D TVE_SAMPLE_01_STOCHASTIC_2D TVE_SAMPLE_01_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_02_PLANAR_2D TVE_SAMPLE_02_PLANAR_3D TVE_SAMPLE_02_STOCHASTIC_2D TVE_SAMPLE_02_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_03_PLANAR_2D TVE_SAMPLE_03_PLANAR_3D TVE_SAMPLE_03_STOCHASTIC_2D TVE_SAMPLE_03_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_04_PLANAR_2D TVE_SAMPLE_04_PLANAR_3D TVE_SAMPLE_04_STOCHASTIC_2D TVE_SAMPLE_04_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_05_PLANAR_2D TVE_SAMPLE_05_PLANAR_3D TVE_SAMPLE_05_STOCHASTIC_2D TVE_SAMPLE_05_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_06_PLANAR_2D TVE_SAMPLE_06_PLANAR_3D TVE_SAMPLE_06_STOCHASTIC_2D TVE_SAMPLE_06_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_07_PLANAR_2D TVE_SAMPLE_07_PLANAR_3D TVE_SAMPLE_07_STOCHASTIC_2D TVE_SAMPLE_07_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_08_PLANAR_2D TVE_SAMPLE_08_PLANAR_3D TVE_SAMPLE_08_STOCHASTIC_2D TVE_SAMPLE_08_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_09_PLANAR_2D TVE_SAMPLE_09_PLANAR_3D TVE_SAMPLE_09_STOCHASTIC_2D TVE_SAMPLE_09_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_10_PLANAR_2D TVE_SAMPLE_10_PLANAR_3D TVE_SAMPLE_10_STOCHASTIC_2D TVE_SAMPLE_10_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_11_PLANAR_2D TVE_SAMPLE_11_PLANAR_3D TVE_SAMPLE_11_STOCHASTIC_2D TVE_SAMPLE_11_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_12_PLANAR_2D TVE_SAMPLE_12_PLANAR_3D TVE_SAMPLE_12_STOCHASTIC_2D TVE_SAMPLE_12_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_13_PLANAR_2D TVE_SAMPLE_13_PLANAR_3D TVE_SAMPLE_13_STOCHASTIC_2D TVE_SAMPLE_13_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_14_PLANAR_2D TVE_SAMPLE_14_PLANAR_3D TVE_SAMPLE_14_STOCHASTIC_2D TVE_SAMPLE_14_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_15_PLANAR_2D TVE_SAMPLE_15_PLANAR_3D TVE_SAMPLE_15_STOCHASTIC_2D TVE_SAMPLE_15_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_16_PLANAR_2D TVE_SAMPLE_16_PLANAR_3D TVE_SAMPLE_16_STOCHASTIC_2D TVE_SAMPLE_16_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_PACKED_TEX
			#pragma shader_feature_local_fragment TVE_EMISSIVE
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap forwardadd
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 uv1 : TEXCOORD3;
				float4 uv2 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};


			void ComputeWorldCoords( half4 Coords, half3 WorldPosition, out half2 ZX, out half2 ZY, out half2 XY )
			{
				ZX = WorldPosition.xz * Coords.xy + Coords.zw;
				ZY = WorldPosition.zy * Coords.xy + Coords.zw; 
				XY = WorldPosition.xy * Coords.xy + Coords.zw;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half4 tex = SAMPLE_TEXTURE2D( Texture, Sampler, ZX);
				return tex;
			}
			
			void ComputeTriplanarWeights( half3 WorldNormal, out half T1, out half T2, out half T3 )
			{
				half3 powNormal = abs( WorldNormal.xyz );
				half3 weights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.000001 );
				weights /= ( weights.x + weights.y + weights.z ).xxx;
				T1 = weights.y;
				T2 = weights.x;
				T3 = weights.z;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition, half3 WorldNormal )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half T1, T2, T3;
				ComputeTriplanarWeights(WorldNormal, T1, T2, T3);
				half4 tex1 = SAMPLE_TEXTURE2D( Texture, Sampler, ZX);
				half4 tex2 = SAMPLE_TEXTURE2D( Texture, Sampler, ZY);
				half4 tex3 = SAMPLE_TEXTURE2D( Texture, Sampler, XY);
				return tex1 * T1 + tex2 * T2 + tex3 * T3;
			}
			
			void ComputeStochasticCoords( float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float W1, out float W2, out float W3 )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					W1 = temp.z;
					W2 = temp.y;
					W3 = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					W1 = -temp.z;
					W2 = 1.0 - temp.y;
					W3 = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex1 ) ) * 43758.5453 );
				UV2 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex2 ) ) * 43758.5453 );
				UV3 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex3 ) ) * 43758.5453 );
				return;
			}
			
			float4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half2 UV1, UV2, UV3;
				half W1, W2, W3;
				ComputeStochasticCoords(ZX, UV1, UV2, UV3, W1, W2, W3 );
				half4 tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZX), ddy(ZX));
				half4 tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZX), ddy(ZX));
				half4 tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZX), ddy(ZX));
				return tex1 * W1 + tex2 * W2 + tex3 * W3;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition, half3 WorldNormal )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half2 UV1, UV2, UV3;
				half W1, W2, W3;
				half4 tex1, tex2, tex3;
				ComputeStochasticCoords(ZX, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZX), ddy(ZX));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZX), ddy(ZX));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZX), ddy(ZX));
				half4 texZX = tex1 * W1 + tex2 * W2 + tex3 * W3;
				ComputeStochasticCoords(ZY, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZY), ddy(ZY));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZY), ddy(ZY));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZY), ddy(ZY));
				half4 texZY = tex1 * W1 + tex2 * W2 + tex3 * W3;
				ComputeStochasticCoords(XY, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(XY), ddy(XY));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(XY), ddy(XY));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(XY), ddy(XY));
				half4 texXY = tex1 * W1 + tex2 * W2 + tex3 * W3;
				half T1, T2, T3;
				ComputeTriplanarWeights(WorldNormal, T1, T2, T3);
				return texZX * T1 + texZY * T2 + texXY * T3;
			}
			
			float3 ASEGetEmissionHDRColor(float3 ldrColor, float luminanceIntensity, float exposureWeight, float inverseCurrentExposureMultiplier)
			{
				float3 hdrColor = ldrColor * luminanceIntensity;
				hdrColor = lerp( hdrColor* inverseCurrentExposureMultiplier, hdrColor, exposureWeight);
				return hdrColor;
			}
			
			AttributesMesh ApplyMeshModification( AttributesMesh inputMesh )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = inputMesh.positionOS.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				inputMesh.positionOS.xz = sampleCoords* _TerrainHeightmapScale.xz;
				inputMesh.positionOS.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					inputMesh.normalOS = float3(0, 1, 0);
				#else
					inputMesh.normalOS = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				inputMesh.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return inputMesh;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				surfaceData.baseColor =					surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
                    float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
	
	            

	            
                #if ASE_SRP_VERSION >=140008
                #ifdef DECAL_NORMAL_BLENDING
					normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normalTS, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;

                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                     }
                    #endif

                    GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
                #else
					GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;
        
                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                    }
                    #endif
                #endif
                #endif
               

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
				    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				    {
					   surfaceData.metallic = 0;
				    }
				    ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData); 
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif  
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification(inputMesh);
				float3 VertexPosition3588_g79798 = inputMesh.positionOS;
				float temp_output_84_0_g79811 = _LayerVertexValue;
				float temp_output_19_0_g79815 = TVE_VertexUsage[(int)temp_output_84_0_g79811];
				float4 temp_output_94_19_g79811 = TVE_VertexCoords;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag7344_g79798 = ase_worldPos;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV97_g79811 = ( (temp_output_94_19_g79811).zw + ( (temp_output_94_19_g79811).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode50_g79811 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g79811,temp_output_84_0_g79811, 0.0 );
				float4 temp_output_17_0_g79815 = tex2DArrayNode50_g79811;
				float4 temp_output_111_19_g79811 = TVE_VertexParams;
				float4 temp_output_3_0_g79815 = temp_output_111_19_g79811;
				float4 ifLocalVar18_g79815 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79815 >= 0.5 )
				ifLocalVar18_g79815 = temp_output_17_0_g79815;
				else
				ifLocalVar18_g79815 = temp_output_3_0_g79815;
				float4 lerpResult22_g79815 = lerp( temp_output_3_0_g79815 , temp_output_17_0_g79815 , temp_output_19_0_g79815);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79815 = lerpResult22_g79815;
				#else
				float4 staticSwitch24_g79815 = ifLocalVar18_g79815;
				#endif
				half4 Global_Vertex_Params4173_g79798 = staticSwitch24_g79815;
				float4 break322_g79802 = Global_Vertex_Params4173_g79798;
				half Global_VertexOffset7327_g79798 = break322_g79802.z;
				float3 appendResult7336_g79798 = (float3(0.0 , ( Global_VertexOffset7327_g79798 * _GlobalHeight ) , 0.0));
				half3 Vertex_Offset7335_g79798 = appendResult7336_g79798;
				float3 Vertex_Output890_g79798 = ( VertexPosition3588_g79798 + Vertex_Offset7335_g79798 );
				
				float4 appendResult7007_g79798 = (float4(cross( inputMesh.normalOS , float3(0,0,1) ) , -1.0));
				half4 Vertex_Tangents7390_g79798 = appendResult7007_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = vertexToFrag7344_g79798;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.tangentOS.xyz);
				float ase_vertexTangentSign = inputMesh.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = ase_worldBitangent;
				
				outputPackedVaryingsMeshToPS.ase_texcoord5.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord5.zw = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Vertex_Output890_g79798;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS = Vertex_Tangents7390_g79798;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.uv1.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.uv2.xyzw = inputMesh.uv2;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput,
						OUTPUT_GBUFFER(outGBuffer)
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
						)
			{

				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.uv1.xyzw;
				input.texCoord2 = packedInput.uv2.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);
				SurfaceData surfaceData;
				BuiltinData builtinData;

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float localHeightBasedBlending7362_g83242 = ( 0.0 );
				float2 Terrain_Control_UV7873_g83242 = packedInput.ase_texcoord5.xy;
				half4 Terrain_Control_047365_g83242 = SAMPLE_TEXTURE2D( _ControlTex1, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_047362_g83242 = Terrain_Control_047365_g83242;
				half4 Terrain_Control_087366_g83242 = SAMPLE_TEXTURE2D( _ControlTex2, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_087362_g83242 = Terrain_Control_087366_g83242;
				half4 Terrain_Control_127712_g83242 = SAMPLE_TEXTURE2D( _ControlTex3, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_127362_g83242 = Terrain_Control_127712_g83242;
				half4 Terrain_Control_167711_g83242 = SAMPLE_TEXTURE2D( _ControlTex4, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_167362_g83242 = Terrain_Control_167711_g83242;
				TEXTURE2D(Texture238_g83299) = _MaskTex1;
				SamplerState Sampler238_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_016785_g83242 = _Coords1;
				float4 temp_output_37_0_g83299 = Input_Coords_016785_g83242;
				half4 Coords238_g83299 = temp_output_37_0_g83299;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				half3 WorldPosition238_g83299 = ase_worldPos;
				half4 localSamplePlanar2D238_g83299 = SamplePlanar2D( Texture238_g83299 , Sampler238_g83299 , Coords238_g83299 , WorldPosition238_g83299 );
				TEXTURE2D(Texture246_g83299) = _MaskTex1;
				SamplerState Sampler246_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83299 = temp_output_37_0_g83299;
				half3 WorldPosition246_g83299 = ase_worldPos;
				half3 WorldNormal246_g83299 = normalWS;
				half4 localSamplePlanar3D246_g83299 = SamplePlanar3D( Texture246_g83299 , Sampler246_g83299 , Coords246_g83299 , WorldPosition246_g83299 , WorldNormal246_g83299 );
				TEXTURE2D(Texture234_g83299) = _MaskTex1;
				SamplerState Sampler234_g83299 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83299 = temp_output_37_0_g83299;
				float3 WorldPosition234_g83299 = ase_worldPos;
				float4 localSampleStochastic2D234_g83299 = SampleStochastic2D( Texture234_g83299 , Sampler234_g83299 , Coords234_g83299 , WorldPosition234_g83299 );
				TEXTURE2D(Texture263_g83299) = _MaskTex1;
				SamplerState Sampler263_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83299 = temp_output_37_0_g83299;
				half3 WorldPosition263_g83299 = ase_worldPos;
				half3 WorldNormal263_g83299 = normalWS;
				half4 localSampleStochastic3D263_g83299 = SampleStochastic3D( Texture263_g83299 , Sampler263_g83299 , Coords263_g83299 , WorldPosition263_g83299 , WorldNormal263_g83299 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8639_g83242 = localSamplePlanar2D238_g83299;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8639_g83242 = localSamplePlanar3D246_g83299;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8639_g83242 = localSampleStochastic2D234_g83299;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8639_g83242 = localSampleStochastic3D263_g83299;
				#else
				float4 staticSwitch8639_g83242 = localSamplePlanar2D238_g83299;
				#endif
				float4 temp_output_7_0_g83248 = _MaskMin1;
				float4 temp_output_10_0_g83248 = ( _MaskMax1 - temp_output_7_0_g83248 );
				float4 temp_output_6970_0_g83242 = saturate( ( ( staticSwitch8639_g83242 - temp_output_7_0_g83248 ) / ( temp_output_10_0_g83248 + 0.0001 ) ) );
				half4 Masks_015_g83256 = temp_output_6970_0_g83242;
				TEXTURE2D(Texture238_g83300) = _MaskTex2;
				SamplerState Sampler238_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_026787_g83242 = _Coords2;
				float4 temp_output_37_0_g83300 = Input_Coords_026787_g83242;
				half4 Coords238_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition238_g83300 = ase_worldPos;
				half4 localSamplePlanar2D238_g83300 = SamplePlanar2D( Texture238_g83300 , Sampler238_g83300 , Coords238_g83300 , WorldPosition238_g83300 );
				TEXTURE2D(Texture246_g83300) = _MaskTex2;
				SamplerState Sampler246_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition246_g83300 = ase_worldPos;
				half3 WorldNormal246_g83300 = normalWS;
				half4 localSamplePlanar3D246_g83300 = SamplePlanar3D( Texture246_g83300 , Sampler246_g83300 , Coords246_g83300 , WorldPosition246_g83300 , WorldNormal246_g83300 );
				TEXTURE2D(Texture234_g83300) = _MaskTex2;
				SamplerState Sampler234_g83300 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83300 = temp_output_37_0_g83300;
				float3 WorldPosition234_g83300 = ase_worldPos;
				float4 localSampleStochastic2D234_g83300 = SampleStochastic2D( Texture234_g83300 , Sampler234_g83300 , Coords234_g83300 , WorldPosition234_g83300 );
				TEXTURE2D(Texture263_g83300) = _MaskTex2;
				SamplerState Sampler263_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition263_g83300 = ase_worldPos;
				half3 WorldNormal263_g83300 = normalWS;
				half4 localSampleStochastic3D263_g83300 = SampleStochastic3D( Texture263_g83300 , Sampler263_g83300 , Coords263_g83300 , WorldPosition263_g83300 , WorldNormal263_g83300 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8640_g83242 = localSamplePlanar2D238_g83300;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8640_g83242 = localSamplePlanar3D246_g83300;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8640_g83242 = localSampleStochastic2D234_g83300;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8640_g83242 = localSampleStochastic3D263_g83300;
				#else
				float4 staticSwitch8640_g83242 = localSamplePlanar2D238_g83300;
				#endif
				float4 temp_output_7_0_g83250 = _MaskMin2;
				float4 temp_output_10_0_g83250 = ( _MaskMax2 - temp_output_7_0_g83250 );
				float4 temp_output_6977_0_g83242 = saturate( ( ( staticSwitch8640_g83242 - temp_output_7_0_g83250 ) / ( temp_output_10_0_g83250 + 0.0001 ) ) );
				half4 Masks_0210_g83256 = temp_output_6977_0_g83242;
				TEXTURE2D(Texture238_g83301) = _MaskTex3;
				SamplerState Sampler238_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_036789_g83242 = _Coords3;
				float4 temp_output_37_0_g83301 = Input_Coords_036789_g83242;
				half4 Coords238_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition238_g83301 = ase_worldPos;
				half4 localSamplePlanar2D238_g83301 = SamplePlanar2D( Texture238_g83301 , Sampler238_g83301 , Coords238_g83301 , WorldPosition238_g83301 );
				TEXTURE2D(Texture246_g83301) = _MaskTex3;
				SamplerState Sampler246_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition246_g83301 = ase_worldPos;
				half3 WorldNormal246_g83301 = normalWS;
				half4 localSamplePlanar3D246_g83301 = SamplePlanar3D( Texture246_g83301 , Sampler246_g83301 , Coords246_g83301 , WorldPosition246_g83301 , WorldNormal246_g83301 );
				TEXTURE2D(Texture234_g83301) = _MaskTex3;
				SamplerState Sampler234_g83301 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83301 = temp_output_37_0_g83301;
				float3 WorldPosition234_g83301 = ase_worldPos;
				float4 localSampleStochastic2D234_g83301 = SampleStochastic2D( Texture234_g83301 , Sampler234_g83301 , Coords234_g83301 , WorldPosition234_g83301 );
				TEXTURE2D(Texture263_g83301) = _MaskTex3;
				SamplerState Sampler263_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition263_g83301 = ase_worldPos;
				half3 WorldNormal263_g83301 = normalWS;
				half4 localSampleStochastic3D263_g83301 = SampleStochastic3D( Texture263_g83301 , Sampler263_g83301 , Coords263_g83301 , WorldPosition263_g83301 , WorldNormal263_g83301 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8641_g83242 = localSamplePlanar2D238_g83301;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8641_g83242 = localSamplePlanar3D246_g83301;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8641_g83242 = localSampleStochastic2D234_g83301;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8641_g83242 = localSampleStochastic3D263_g83301;
				#else
				float4 staticSwitch8641_g83242 = localSamplePlanar2D238_g83301;
				#endif
				float4 temp_output_7_0_g83251 = _MaskMin3;
				float4 temp_output_10_0_g83251 = ( _MaskMax3 - temp_output_7_0_g83251 );
				float4 temp_output_6978_0_g83242 = saturate( ( ( staticSwitch8641_g83242 - temp_output_7_0_g83251 ) / ( temp_output_10_0_g83251 + 0.0001 ) ) );
				half4 Masks_0312_g83256 = temp_output_6978_0_g83242;
				TEXTURE2D(Texture238_g83302) = _MaskTex4;
				SamplerState Sampler238_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_046791_g83242 = _Coords4;
				float4 temp_output_37_0_g83302 = Input_Coords_046791_g83242;
				half4 Coords238_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition238_g83302 = ase_worldPos;
				half4 localSamplePlanar2D238_g83302 = SamplePlanar2D( Texture238_g83302 , Sampler238_g83302 , Coords238_g83302 , WorldPosition238_g83302 );
				TEXTURE2D(Texture246_g83302) = _MaskTex4;
				SamplerState Sampler246_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition246_g83302 = ase_worldPos;
				half3 WorldNormal246_g83302 = normalWS;
				half4 localSamplePlanar3D246_g83302 = SamplePlanar3D( Texture246_g83302 , Sampler246_g83302 , Coords246_g83302 , WorldPosition246_g83302 , WorldNormal246_g83302 );
				TEXTURE2D(Texture234_g83302) = _MaskTex4;
				SamplerState Sampler234_g83302 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83302 = temp_output_37_0_g83302;
				float3 WorldPosition234_g83302 = ase_worldPos;
				float4 localSampleStochastic2D234_g83302 = SampleStochastic2D( Texture234_g83302 , Sampler234_g83302 , Coords234_g83302 , WorldPosition234_g83302 );
				TEXTURE2D(Texture263_g83302) = _MaskTex4;
				SamplerState Sampler263_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition263_g83302 = ase_worldPos;
				half3 WorldNormal263_g83302 = normalWS;
				half4 localSampleStochastic3D263_g83302 = SampleStochastic3D( Texture263_g83302 , Sampler263_g83302 , Coords263_g83302 , WorldPosition263_g83302 , WorldNormal263_g83302 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8642_g83242 = localSamplePlanar2D238_g83302;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8642_g83242 = localSamplePlanar3D246_g83302;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8642_g83242 = localSampleStochastic2D234_g83302;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8642_g83242 = localSampleStochastic3D263_g83302;
				#else
				float4 staticSwitch8642_g83242 = localSamplePlanar2D238_g83302;
				#endif
				float4 temp_output_7_0_g83252 = _MaskMin4;
				float4 temp_output_10_0_g83252 = ( _MaskMax4 - temp_output_7_0_g83252 );
				float4 temp_output_6983_0_g83242 = saturate( ( ( staticSwitch8642_g83242 - temp_output_7_0_g83252 ) / ( temp_output_10_0_g83252 + 0.0001 ) ) );
				half4 Masks_0414_g83256 = temp_output_6983_0_g83242;
				float4 appendResult29_g83256 = (float4((Masks_015_g83256).z , (Masks_0210_g83256).z , (Masks_0312_g83256).z , (Masks_0414_g83256).z));
				half4 Control31_g83256 = Terrain_Control_047365_g83242;
				half4 Terrain_Height_047210_g83242 = ( appendResult29_g83256 * Control31_g83256 );
				float4 heights_047362_g83242 = Terrain_Height_047210_g83242;
				TEXTURE2D(Texture238_g83311) = _MaskTex5;
				SamplerState Sampler238_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_058750_g83242 = _Coords5;
				float4 temp_output_37_0_g83311 = Input_Coords_058750_g83242;
				half4 Coords238_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition238_g83311 = ase_worldPos;
				half4 localSamplePlanar2D238_g83311 = SamplePlanar2D( Texture238_g83311 , Sampler238_g83311 , Coords238_g83311 , WorldPosition238_g83311 );
				TEXTURE2D(Texture246_g83311) = _MaskTex5;
				SamplerState Sampler246_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition246_g83311 = ase_worldPos;
				half3 WorldNormal246_g83311 = normalWS;
				half4 localSamplePlanar3D246_g83311 = SamplePlanar3D( Texture246_g83311 , Sampler246_g83311 , Coords246_g83311 , WorldPosition246_g83311 , WorldNormal246_g83311 );
				TEXTURE2D(Texture234_g83311) = _MaskTex5;
				SamplerState Sampler234_g83311 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83311 = temp_output_37_0_g83311;
				float3 WorldPosition234_g83311 = ase_worldPos;
				float4 localSampleStochastic2D234_g83311 = SampleStochastic2D( Texture234_g83311 , Sampler234_g83311 , Coords234_g83311 , WorldPosition234_g83311 );
				TEXTURE2D(Texture263_g83311) = _MaskTex5;
				SamplerState Sampler263_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition263_g83311 = ase_worldPos;
				half3 WorldNormal263_g83311 = normalWS;
				half4 localSampleStochastic3D263_g83311 = SampleStochastic3D( Texture263_g83311 , Sampler263_g83311 , Coords263_g83311 , WorldPosition263_g83311 , WorldNormal263_g83311 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8710_g83242 = localSamplePlanar2D238_g83311;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8710_g83242 = localSamplePlanar3D246_g83311;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8710_g83242 = localSampleStochastic2D234_g83311;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8710_g83242 = localSampleStochastic3D263_g83311;
				#else
				float4 staticSwitch8710_g83242 = localSamplePlanar2D238_g83311;
				#endif
				float4 temp_output_7_0_g83264 = _MaskMin5;
				float4 temp_output_10_0_g83264 = ( _MaskMax5 - temp_output_7_0_g83264 );
				float4 temp_output_8714_0_g83242 = saturate( ( ( staticSwitch8710_g83242 - temp_output_7_0_g83264 ) / ( temp_output_10_0_g83264 + 0.0001 ) ) );
				half4 Masks_015_g83265 = temp_output_8714_0_g83242;
				TEXTURE2D(Texture238_g83312) = _MaskTex6;
				SamplerState Sampler238_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_068751_g83242 = _Coords6;
				float4 temp_output_37_0_g83312 = Input_Coords_068751_g83242;
				half4 Coords238_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition238_g83312 = ase_worldPos;
				half4 localSamplePlanar2D238_g83312 = SamplePlanar2D( Texture238_g83312 , Sampler238_g83312 , Coords238_g83312 , WorldPosition238_g83312 );
				TEXTURE2D(Texture246_g83312) = _MaskTex6;
				SamplerState Sampler246_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition246_g83312 = ase_worldPos;
				half3 WorldNormal246_g83312 = normalWS;
				half4 localSamplePlanar3D246_g83312 = SamplePlanar3D( Texture246_g83312 , Sampler246_g83312 , Coords246_g83312 , WorldPosition246_g83312 , WorldNormal246_g83312 );
				TEXTURE2D(Texture234_g83312) = _MaskTex6;
				SamplerState Sampler234_g83312 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83312 = temp_output_37_0_g83312;
				float3 WorldPosition234_g83312 = ase_worldPos;
				float4 localSampleStochastic2D234_g83312 = SampleStochastic2D( Texture234_g83312 , Sampler234_g83312 , Coords234_g83312 , WorldPosition234_g83312 );
				TEXTURE2D(Texture263_g83312) = _MaskTex6;
				SamplerState Sampler263_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition263_g83312 = ase_worldPos;
				half3 WorldNormal263_g83312 = normalWS;
				half4 localSampleStochastic3D263_g83312 = SampleStochastic3D( Texture263_g83312 , Sampler263_g83312 , Coords263_g83312 , WorldPosition263_g83312 , WorldNormal263_g83312 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8711_g83242 = localSamplePlanar2D238_g83312;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8711_g83242 = localSamplePlanar3D246_g83312;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8711_g83242 = localSampleStochastic2D234_g83312;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8711_g83242 = localSampleStochastic3D263_g83312;
				#else
				float4 staticSwitch8711_g83242 = localSamplePlanar2D238_g83312;
				#endif
				float4 temp_output_7_0_g83267 = _MaskMin6;
				float4 temp_output_10_0_g83267 = ( _MaskMax6 - temp_output_7_0_g83267 );
				float4 temp_output_8721_0_g83242 = saturate( ( ( staticSwitch8711_g83242 - temp_output_7_0_g83267 ) / ( temp_output_10_0_g83267 + 0.0001 ) ) );
				half4 Masks_0210_g83265 = temp_output_8721_0_g83242;
				TEXTURE2D(Texture238_g83313) = _MaskTex7;
				SamplerState Sampler238_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_078752_g83242 = _Coords7;
				float4 temp_output_37_0_g83313 = Input_Coords_078752_g83242;
				half4 Coords238_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition238_g83313 = ase_worldPos;
				half4 localSamplePlanar2D238_g83313 = SamplePlanar2D( Texture238_g83313 , Sampler238_g83313 , Coords238_g83313 , WorldPosition238_g83313 );
				TEXTURE2D(Texture246_g83313) = _MaskTex7;
				SamplerState Sampler246_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition246_g83313 = ase_worldPos;
				half3 WorldNormal246_g83313 = normalWS;
				half4 localSamplePlanar3D246_g83313 = SamplePlanar3D( Texture246_g83313 , Sampler246_g83313 , Coords246_g83313 , WorldPosition246_g83313 , WorldNormal246_g83313 );
				TEXTURE2D(Texture234_g83313) = _MaskTex7;
				SamplerState Sampler234_g83313 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83313 = temp_output_37_0_g83313;
				float3 WorldPosition234_g83313 = ase_worldPos;
				float4 localSampleStochastic2D234_g83313 = SampleStochastic2D( Texture234_g83313 , Sampler234_g83313 , Coords234_g83313 , WorldPosition234_g83313 );
				TEXTURE2D(Texture263_g83313) = _MaskTex7;
				SamplerState Sampler263_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition263_g83313 = ase_worldPos;
				half3 WorldNormal263_g83313 = normalWS;
				half4 localSampleStochastic3D263_g83313 = SampleStochastic3D( Texture263_g83313 , Sampler263_g83313 , Coords263_g83313 , WorldPosition263_g83313 , WorldNormal263_g83313 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8712_g83242 = localSamplePlanar2D238_g83313;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8712_g83242 = localSamplePlanar3D246_g83313;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8712_g83242 = localSampleStochastic2D234_g83313;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8712_g83242 = localSampleStochastic3D263_g83313;
				#else
				float4 staticSwitch8712_g83242 = localSamplePlanar2D238_g83313;
				#endif
				float4 temp_output_7_0_g83268 = _MaskMin7;
				float4 temp_output_10_0_g83268 = ( _MaskMax7 - temp_output_7_0_g83268 );
				float4 temp_output_8724_0_g83242 = saturate( ( ( staticSwitch8712_g83242 - temp_output_7_0_g83268 ) / ( temp_output_10_0_g83268 + 0.0001 ) ) );
				half4 Masks_0312_g83265 = temp_output_8724_0_g83242;
				TEXTURE2D(Texture238_g83314) = _MaskTex8;
				SamplerState Sampler238_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_088749_g83242 = _Coords8;
				float4 temp_output_37_0_g83314 = Input_Coords_088749_g83242;
				half4 Coords238_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition238_g83314 = ase_worldPos;
				half4 localSamplePlanar2D238_g83314 = SamplePlanar2D( Texture238_g83314 , Sampler238_g83314 , Coords238_g83314 , WorldPosition238_g83314 );
				TEXTURE2D(Texture246_g83314) = _MaskTex8;
				SamplerState Sampler246_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition246_g83314 = ase_worldPos;
				half3 WorldNormal246_g83314 = normalWS;
				half4 localSamplePlanar3D246_g83314 = SamplePlanar3D( Texture246_g83314 , Sampler246_g83314 , Coords246_g83314 , WorldPosition246_g83314 , WorldNormal246_g83314 );
				TEXTURE2D(Texture234_g83314) = _MaskTex8;
				SamplerState Sampler234_g83314 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83314 = temp_output_37_0_g83314;
				float3 WorldPosition234_g83314 = ase_worldPos;
				float4 localSampleStochastic2D234_g83314 = SampleStochastic2D( Texture234_g83314 , Sampler234_g83314 , Coords234_g83314 , WorldPosition234_g83314 );
				TEXTURE2D(Texture263_g83314) = _MaskTex8;
				SamplerState Sampler263_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition263_g83314 = ase_worldPos;
				half3 WorldNormal263_g83314 = normalWS;
				half4 localSampleStochastic3D263_g83314 = SampleStochastic3D( Texture263_g83314 , Sampler263_g83314 , Coords263_g83314 , WorldPosition263_g83314 , WorldNormal263_g83314 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8713_g83242 = localSamplePlanar2D238_g83314;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8713_g83242 = localSamplePlanar3D246_g83314;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8713_g83242 = localSampleStochastic2D234_g83314;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8713_g83242 = localSampleStochastic3D263_g83314;
				#else
				float4 staticSwitch8713_g83242 = localSamplePlanar2D238_g83314;
				#endif
				float4 temp_output_7_0_g83269 = _MaskMin8;
				float4 temp_output_10_0_g83269 = ( _MaskMax8 - temp_output_7_0_g83269 );
				float4 temp_output_8727_0_g83242 = saturate( ( ( staticSwitch8713_g83242 - temp_output_7_0_g83269 ) / ( temp_output_10_0_g83269 + 0.0001 ) ) );
				half4 Masks_0414_g83265 = temp_output_8727_0_g83242;
				float4 appendResult29_g83265 = (float4((Masks_015_g83265).z , (Masks_0210_g83265).z , (Masks_0312_g83265).z , (Masks_0414_g83265).z));
				half4 Control31_g83265 = Terrain_Control_087366_g83242;
				half4 Terrain_Height_088731_g83242 = ( appendResult29_g83265 * Control31_g83265 );
				float4 heights_087362_g83242 = Terrain_Height_088731_g83242;
				TEXTURE2D(Texture238_g83323) = _MaskTex9;
				SamplerState Sampler238_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_098833_g83242 = _Coords9;
				float4 temp_output_37_0_g83323 = Input_Coords_098833_g83242;
				half4 Coords238_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition238_g83323 = ase_worldPos;
				half4 localSamplePlanar2D238_g83323 = SamplePlanar2D( Texture238_g83323 , Sampler238_g83323 , Coords238_g83323 , WorldPosition238_g83323 );
				TEXTURE2D(Texture246_g83323) = _MaskTex9;
				SamplerState Sampler246_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition246_g83323 = ase_worldPos;
				half3 WorldNormal246_g83323 = normalWS;
				half4 localSamplePlanar3D246_g83323 = SamplePlanar3D( Texture246_g83323 , Sampler246_g83323 , Coords246_g83323 , WorldPosition246_g83323 , WorldNormal246_g83323 );
				TEXTURE2D(Texture234_g83323) = _MaskTex9;
				SamplerState Sampler234_g83323 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83323 = temp_output_37_0_g83323;
				float3 WorldPosition234_g83323 = ase_worldPos;
				float4 localSampleStochastic2D234_g83323 = SampleStochastic2D( Texture234_g83323 , Sampler234_g83323 , Coords234_g83323 , WorldPosition234_g83323 );
				TEXTURE2D(Texture263_g83323) = _MaskTex9;
				SamplerState Sampler263_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition263_g83323 = ase_worldPos;
				half3 WorldNormal263_g83323 = normalWS;
				half4 localSampleStochastic3D263_g83323 = SampleStochastic3D( Texture263_g83323 , Sampler263_g83323 , Coords263_g83323 , WorldPosition263_g83323 , WorldNormal263_g83323 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8878_g83242 = localSamplePlanar2D238_g83323;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8878_g83242 = localSamplePlanar3D246_g83323;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8878_g83242 = localSampleStochastic2D234_g83323;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8878_g83242 = localSampleStochastic3D263_g83323;
				#else
				float4 staticSwitch8878_g83242 = localSamplePlanar2D238_g83323;
				#endif
				float4 temp_output_7_0_g83274 = _MaskMin9;
				float4 temp_output_10_0_g83274 = ( _MaskMax9 - temp_output_7_0_g83274 );
				float4 temp_output_8815_0_g83242 = saturate( ( ( staticSwitch8878_g83242 - temp_output_7_0_g83274 ) / ( temp_output_10_0_g83274 + 0.0001 ) ) );
				half4 Masks_015_g83275 = temp_output_8815_0_g83242;
				TEXTURE2D(Texture238_g83324) = _MaskTex10;
				SamplerState Sampler238_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_108834_g83242 = _Coords10;
				float4 temp_output_37_0_g83324 = Input_Coords_108834_g83242;
				half4 Coords238_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition238_g83324 = ase_worldPos;
				half4 localSamplePlanar2D238_g83324 = SamplePlanar2D( Texture238_g83324 , Sampler238_g83324 , Coords238_g83324 , WorldPosition238_g83324 );
				TEXTURE2D(Texture246_g83324) = _MaskTex10;
				SamplerState Sampler246_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition246_g83324 = ase_worldPos;
				half3 WorldNormal246_g83324 = normalWS;
				half4 localSamplePlanar3D246_g83324 = SamplePlanar3D( Texture246_g83324 , Sampler246_g83324 , Coords246_g83324 , WorldPosition246_g83324 , WorldNormal246_g83324 );
				TEXTURE2D(Texture234_g83324) = _MaskTex10;
				SamplerState Sampler234_g83324 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83324 = temp_output_37_0_g83324;
				float3 WorldPosition234_g83324 = ase_worldPos;
				float4 localSampleStochastic2D234_g83324 = SampleStochastic2D( Texture234_g83324 , Sampler234_g83324 , Coords234_g83324 , WorldPosition234_g83324 );
				TEXTURE2D(Texture263_g83324) = _MaskTex10;
				SamplerState Sampler263_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition263_g83324 = ase_worldPos;
				half3 WorldNormal263_g83324 = normalWS;
				half4 localSampleStochastic3D263_g83324 = SampleStochastic3D( Texture263_g83324 , Sampler263_g83324 , Coords263_g83324 , WorldPosition263_g83324 , WorldNormal263_g83324 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8860_g83242 = localSamplePlanar2D238_g83324;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8860_g83242 = localSamplePlanar3D246_g83324;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8860_g83242 = localSampleStochastic2D234_g83324;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8860_g83242 = localSampleStochastic3D263_g83324;
				#else
				float4 staticSwitch8860_g83242 = localSamplePlanar2D238_g83324;
				#endif
				float4 temp_output_7_0_g83277 = _MaskMin10;
				float4 temp_output_10_0_g83277 = ( _MaskMax10 - temp_output_7_0_g83277 );
				float4 temp_output_8818_0_g83242 = saturate( ( ( staticSwitch8860_g83242 - temp_output_7_0_g83277 ) / ( temp_output_10_0_g83277 + 0.0001 ) ) );
				half4 Masks_0210_g83275 = temp_output_8818_0_g83242;
				TEXTURE2D(Texture238_g83325) = _MaskTex11;
				SamplerState Sampler238_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_118835_g83242 = _Coords11;
				float4 temp_output_37_0_g83325 = Input_Coords_118835_g83242;
				half4 Coords238_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition238_g83325 = ase_worldPos;
				half4 localSamplePlanar2D238_g83325 = SamplePlanar2D( Texture238_g83325 , Sampler238_g83325 , Coords238_g83325 , WorldPosition238_g83325 );
				TEXTURE2D(Texture246_g83325) = _MaskTex11;
				SamplerState Sampler246_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition246_g83325 = ase_worldPos;
				half3 WorldNormal246_g83325 = normalWS;
				half4 localSamplePlanar3D246_g83325 = SamplePlanar3D( Texture246_g83325 , Sampler246_g83325 , Coords246_g83325 , WorldPosition246_g83325 , WorldNormal246_g83325 );
				TEXTURE2D(Texture234_g83325) = _MaskTex11;
				SamplerState Sampler234_g83325 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83325 = temp_output_37_0_g83325;
				float3 WorldPosition234_g83325 = ase_worldPos;
				float4 localSampleStochastic2D234_g83325 = SampleStochastic2D( Texture234_g83325 , Sampler234_g83325 , Coords234_g83325 , WorldPosition234_g83325 );
				TEXTURE2D(Texture263_g83325) = _MaskTex11;
				SamplerState Sampler263_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition263_g83325 = ase_worldPos;
				half3 WorldNormal263_g83325 = normalWS;
				half4 localSampleStochastic3D263_g83325 = SampleStochastic3D( Texture263_g83325 , Sampler263_g83325 , Coords263_g83325 , WorldPosition263_g83325 , WorldNormal263_g83325 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8861_g83242 = localSamplePlanar2D238_g83325;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8861_g83242 = localSamplePlanar3D246_g83325;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8861_g83242 = localSampleStochastic2D234_g83325;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8861_g83242 = localSampleStochastic3D263_g83325;
				#else
				float4 staticSwitch8861_g83242 = localSamplePlanar2D238_g83325;
				#endif
				float4 temp_output_7_0_g83278 = _MaskMin11;
				float4 temp_output_10_0_g83278 = ( _MaskMax11 - temp_output_7_0_g83278 );
				float4 temp_output_8819_0_g83242 = saturate( ( ( staticSwitch8861_g83242 - temp_output_7_0_g83278 ) / ( temp_output_10_0_g83278 + 0.0001 ) ) );
				half4 Masks_0312_g83275 = temp_output_8819_0_g83242;
				TEXTURE2D(Texture238_g83326) = _MaskTex12;
				SamplerState Sampler238_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_128836_g83242 = _Coords12;
				float4 temp_output_37_0_g83326 = Input_Coords_128836_g83242;
				half4 Coords238_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition238_g83326 = ase_worldPos;
				half4 localSamplePlanar2D238_g83326 = SamplePlanar2D( Texture238_g83326 , Sampler238_g83326 , Coords238_g83326 , WorldPosition238_g83326 );
				TEXTURE2D(Texture246_g83326) = _MaskTex12;
				SamplerState Sampler246_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition246_g83326 = ase_worldPos;
				half3 WorldNormal246_g83326 = normalWS;
				half4 localSamplePlanar3D246_g83326 = SamplePlanar3D( Texture246_g83326 , Sampler246_g83326 , Coords246_g83326 , WorldPosition246_g83326 , WorldNormal246_g83326 );
				TEXTURE2D(Texture234_g83326) = _MaskTex12;
				SamplerState Sampler234_g83326 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83326 = temp_output_37_0_g83326;
				float3 WorldPosition234_g83326 = ase_worldPos;
				float4 localSampleStochastic2D234_g83326 = SampleStochastic2D( Texture234_g83326 , Sampler234_g83326 , Coords234_g83326 , WorldPosition234_g83326 );
				TEXTURE2D(Texture263_g83326) = _MaskTex12;
				SamplerState Sampler263_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition263_g83326 = ase_worldPos;
				half3 WorldNormal263_g83326 = normalWS;
				half4 localSampleStochastic3D263_g83326 = SampleStochastic3D( Texture263_g83326 , Sampler263_g83326 , Coords263_g83326 , WorldPosition263_g83326 , WorldNormal263_g83326 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8879_g83242 = localSamplePlanar2D238_g83326;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8879_g83242 = localSamplePlanar3D246_g83326;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8879_g83242 = localSampleStochastic2D234_g83326;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8879_g83242 = localSampleStochastic3D263_g83326;
				#else
				float4 staticSwitch8879_g83242 = localSamplePlanar2D238_g83326;
				#endif
				float4 temp_output_7_0_g83279 = _MaskMin12;
				float4 temp_output_10_0_g83279 = ( _MaskMax12 - temp_output_7_0_g83279 );
				float4 temp_output_8820_0_g83242 = saturate( ( ( staticSwitch8879_g83242 - temp_output_7_0_g83279 ) / ( temp_output_10_0_g83279 + 0.0001 ) ) );
				half4 Masks_0414_g83275 = temp_output_8820_0_g83242;
				float4 appendResult29_g83275 = (float4((Masks_015_g83275).z , (Masks_0210_g83275).z , (Masks_0312_g83275).z , (Masks_0414_g83275).z));
				half4 Control31_g83275 = Terrain_Control_127712_g83242;
				half4 Terrain_Height_128870_g83242 = ( appendResult29_g83275 * Control31_g83275 );
				float4 heights_127362_g83242 = Terrain_Height_128870_g83242;
				TEXTURE2D(Texture238_g83334) = _MaskTex13;
				SamplerState Sampler238_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_138960_g83242 = _Coords13;
				float4 temp_output_37_0_g83334 = Input_Coords_138960_g83242;
				half4 Coords238_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition238_g83334 = ase_worldPos;
				half4 localSamplePlanar2D238_g83334 = SamplePlanar2D( Texture238_g83334 , Sampler238_g83334 , Coords238_g83334 , WorldPosition238_g83334 );
				TEXTURE2D(Texture246_g83334) = _MaskTex13;
				SamplerState Sampler246_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition246_g83334 = ase_worldPos;
				half3 WorldNormal246_g83334 = normalWS;
				half4 localSamplePlanar3D246_g83334 = SamplePlanar3D( Texture246_g83334 , Sampler246_g83334 , Coords246_g83334 , WorldPosition246_g83334 , WorldNormal246_g83334 );
				TEXTURE2D(Texture234_g83334) = _MaskTex13;
				SamplerState Sampler234_g83334 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83334 = temp_output_37_0_g83334;
				float3 WorldPosition234_g83334 = ase_worldPos;
				float4 localSampleStochastic2D234_g83334 = SampleStochastic2D( Texture234_g83334 , Sampler234_g83334 , Coords234_g83334 , WorldPosition234_g83334 );
				TEXTURE2D(Texture263_g83334) = _MaskTex13;
				SamplerState Sampler263_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition263_g83334 = ase_worldPos;
				half3 WorldNormal263_g83334 = normalWS;
				half4 localSampleStochastic3D263_g83334 = SampleStochastic3D( Texture263_g83334 , Sampler263_g83334 , Coords263_g83334 , WorldPosition263_g83334 , WorldNormal263_g83334 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch9000_g83242 = localSamplePlanar2D238_g83334;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch9000_g83242 = localSamplePlanar3D246_g83334;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch9000_g83242 = localSampleStochastic2D234_g83334;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch9000_g83242 = localSampleStochastic3D263_g83334;
				#else
				float4 staticSwitch9000_g83242 = localSamplePlanar2D238_g83334;
				#endif
				float4 temp_output_7_0_g83284 = _MaskMin13;
				float4 temp_output_10_0_g83284 = ( _MaskMax13 - temp_output_7_0_g83284 );
				float4 temp_output_8931_0_g83242 = saturate( ( ( staticSwitch9000_g83242 - temp_output_7_0_g83284 ) / ( temp_output_10_0_g83284 + 0.0001 ) ) );
				half4 Masks_015_g83285 = temp_output_8931_0_g83242;
				TEXTURE2D(Texture238_g83335) = _MaskTex14;
				SamplerState Sampler238_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_148961_g83242 = _Coords14;
				float4 temp_output_37_0_g83335 = Input_Coords_148961_g83242;
				half4 Coords238_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition238_g83335 = ase_worldPos;
				half4 localSamplePlanar2D238_g83335 = SamplePlanar2D( Texture238_g83335 , Sampler238_g83335 , Coords238_g83335 , WorldPosition238_g83335 );
				TEXTURE2D(Texture246_g83335) = _MaskTex14;
				SamplerState Sampler246_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition246_g83335 = ase_worldPos;
				half3 WorldNormal246_g83335 = normalWS;
				half4 localSamplePlanar3D246_g83335 = SamplePlanar3D( Texture246_g83335 , Sampler246_g83335 , Coords246_g83335 , WorldPosition246_g83335 , WorldNormal246_g83335 );
				TEXTURE2D(Texture234_g83335) = _MaskTex14;
				SamplerState Sampler234_g83335 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83335 = temp_output_37_0_g83335;
				float3 WorldPosition234_g83335 = ase_worldPos;
				float4 localSampleStochastic2D234_g83335 = SampleStochastic2D( Texture234_g83335 , Sampler234_g83335 , Coords234_g83335 , WorldPosition234_g83335 );
				TEXTURE2D(Texture263_g83335) = _MaskTex14;
				SamplerState Sampler263_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition263_g83335 = ase_worldPos;
				half3 WorldNormal263_g83335 = normalWS;
				half4 localSampleStochastic3D263_g83335 = SampleStochastic3D( Texture263_g83335 , Sampler263_g83335 , Coords263_g83335 , WorldPosition263_g83335 , WorldNormal263_g83335 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch9001_g83242 = localSamplePlanar2D238_g83335;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch9001_g83242 = localSamplePlanar3D246_g83335;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch9001_g83242 = localSampleStochastic2D234_g83335;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch9001_g83242 = localSampleStochastic3D263_g83335;
				#else
				float4 staticSwitch9001_g83242 = localSamplePlanar2D238_g83335;
				#endif
				float4 temp_output_7_0_g83287 = _MaskMin14;
				float4 temp_output_10_0_g83287 = ( _MaskMax14 - temp_output_7_0_g83287 );
				float4 temp_output_8934_0_g83242 = saturate( ( ( staticSwitch9001_g83242 - temp_output_7_0_g83287 ) / ( temp_output_10_0_g83287 + 0.0001 ) ) );
				half4 Masks_0210_g83285 = temp_output_8934_0_g83242;
				TEXTURE2D(Texture238_g83336) = _MaskTex15;
				SamplerState Sampler238_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_158962_g83242 = _Coords15;
				float4 temp_output_37_0_g83336 = Input_Coords_158962_g83242;
				half4 Coords238_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition238_g83336 = ase_worldPos;
				half4 localSamplePlanar2D238_g83336 = SamplePlanar2D( Texture238_g83336 , Sampler238_g83336 , Coords238_g83336 , WorldPosition238_g83336 );
				TEXTURE2D(Texture246_g83336) = _MaskTex15;
				SamplerState Sampler246_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition246_g83336 = ase_worldPos;
				half3 WorldNormal246_g83336 = normalWS;
				half4 localSamplePlanar3D246_g83336 = SamplePlanar3D( Texture246_g83336 , Sampler246_g83336 , Coords246_g83336 , WorldPosition246_g83336 , WorldNormal246_g83336 );
				TEXTURE2D(Texture234_g83336) = _MaskTex15;
				SamplerState Sampler234_g83336 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83336 = temp_output_37_0_g83336;
				float3 WorldPosition234_g83336 = ase_worldPos;
				float4 localSampleStochastic2D234_g83336 = SampleStochastic2D( Texture234_g83336 , Sampler234_g83336 , Coords234_g83336 , WorldPosition234_g83336 );
				TEXTURE2D(Texture263_g83336) = _MaskTex15;
				SamplerState Sampler263_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition263_g83336 = ase_worldPos;
				half3 WorldNormal263_g83336 = normalWS;
				half4 localSampleStochastic3D263_g83336 = SampleStochastic3D( Texture263_g83336 , Sampler263_g83336 , Coords263_g83336 , WorldPosition263_g83336 , WorldNormal263_g83336 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch9002_g83242 = localSamplePlanar2D238_g83336;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch9002_g83242 = localSamplePlanar3D246_g83336;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch9002_g83242 = localSampleStochastic2D234_g83336;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch9002_g83242 = localSampleStochastic3D263_g83336;
				#else
				float4 staticSwitch9002_g83242 = localSamplePlanar2D238_g83336;
				#endif
				float4 temp_output_7_0_g83288 = _MaskMin15;
				float4 temp_output_10_0_g83288 = ( _MaskMax15 - temp_output_7_0_g83288 );
				float4 temp_output_8935_0_g83242 = saturate( ( ( staticSwitch9002_g83242 - temp_output_7_0_g83288 ) / ( temp_output_10_0_g83288 + 0.0001 ) ) );
				half4 Masks_0312_g83285 = temp_output_8935_0_g83242;
				TEXTURE2D(Texture238_g83337) = _MaskTex16;
				SamplerState Sampler238_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_168959_g83242 = _Coords16;
				float4 temp_output_37_0_g83337 = Input_Coords_168959_g83242;
				half4 Coords238_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition238_g83337 = ase_worldPos;
				half4 localSamplePlanar2D238_g83337 = SamplePlanar2D( Texture238_g83337 , Sampler238_g83337 , Coords238_g83337 , WorldPosition238_g83337 );
				TEXTURE2D(Texture246_g83337) = _MaskTex16;
				SamplerState Sampler246_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition246_g83337 = ase_worldPos;
				half3 WorldNormal246_g83337 = normalWS;
				half4 localSamplePlanar3D246_g83337 = SamplePlanar3D( Texture246_g83337 , Sampler246_g83337 , Coords246_g83337 , WorldPosition246_g83337 , WorldNormal246_g83337 );
				TEXTURE2D(Texture234_g83337) = _MaskTex16;
				SamplerState Sampler234_g83337 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83337 = temp_output_37_0_g83337;
				float3 WorldPosition234_g83337 = ase_worldPos;
				float4 localSampleStochastic2D234_g83337 = SampleStochastic2D( Texture234_g83337 , Sampler234_g83337 , Coords234_g83337 , WorldPosition234_g83337 );
				TEXTURE2D(Texture263_g83337) = _MaskTex16;
				SamplerState Sampler263_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition263_g83337 = ase_worldPos;
				half3 WorldNormal263_g83337 = normalWS;
				half4 localSampleStochastic3D263_g83337 = SampleStochastic3D( Texture263_g83337 , Sampler263_g83337 , Coords263_g83337 , WorldPosition263_g83337 , WorldNormal263_g83337 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch9003_g83242 = localSamplePlanar2D238_g83337;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch9003_g83242 = localSamplePlanar3D246_g83337;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch9003_g83242 = localSampleStochastic2D234_g83337;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch9003_g83242 = localSampleStochastic3D263_g83337;
				#else
				float4 staticSwitch9003_g83242 = localSamplePlanar2D238_g83337;
				#endif
				float4 temp_output_7_0_g83289 = _MaskMin16;
				float4 temp_output_10_0_g83289 = ( _MaskMax16 - temp_output_7_0_g83289 );
				float4 temp_output_8936_0_g83242 = saturate( ( ( staticSwitch9003_g83242 - temp_output_7_0_g83289 ) / ( temp_output_10_0_g83289 + 0.0001 ) ) );
				half4 Masks_0414_g83285 = temp_output_8936_0_g83242;
				float4 appendResult29_g83285 = (float4((Masks_015_g83285).z , (Masks_0210_g83285).z , (Masks_0312_g83285).z , (Masks_0414_g83285).z));
				half4 Control31_g83285 = Terrain_Control_167711_g83242;
				half4 Terrain_Height_169015_g83242 = ( appendResult29_g83285 * Control31_g83285 );
				float4 heights_167362_g83242 = Terrain_Height_169015_g83242;
				float heightTransition7362_g83242 = ( 1.0 - _TerrainHeightBlendValue );
				float4 weights_047362_g83242 = float4( 0,0,0,0 );
				float4 weights_087362_g83242 = float4( 0,0,0,0 );
				float4 weights_127362_g83242 = float4( 0,0,0,0 );
				float4 weights_167362_g83242 = float4( 0,0,0,0 );
				{
				//Modified version of the HDRP terrain height based blending
				float maxHeight = 0;
				float4 weightedHeights_04 = float4( 0,0,0,0 );
				float4 weightedHeights_08 = float4( 0,0,0,0 );
				float4 weightedHeights_12 = float4( 0,0,0,0 );
				float4 weightedHeights_16 = float4( 0,0,0,0 );
				maxHeight = heights_047362_g83242.x;
				maxHeight = max(maxHeight, heights_047362_g83242.y);
				maxHeight = max(maxHeight, heights_047362_g83242.z);
				maxHeight = max(maxHeight, heights_047362_g83242.w);
				#ifdef TVE_TERRAIN_08
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				#endif
				#ifdef TVE_TERRAIN_12
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				maxHeight = max(maxHeight, heights_127362_g83242.x);
				maxHeight = max(maxHeight, heights_127362_g83242.y);
				maxHeight = max(maxHeight, heights_127362_g83242.z);
				maxHeight = max(maxHeight, heights_127362_g83242.w);
				#endif
				#ifdef TVE_TERRAIN_16
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				maxHeight = max(maxHeight, heights_127362_g83242.x);
				maxHeight = max(maxHeight, heights_127362_g83242.y);
				maxHeight = max(maxHeight, heights_127362_g83242.z);
				maxHeight = max(maxHeight, heights_127362_g83242.w);
				maxHeight = max(maxHeight, heights_167362_g83242.x);
				maxHeight = max(maxHeight, heights_167362_g83242.y);
				maxHeight = max(maxHeight, heights_167362_g83242.z);
				maxHeight = max(maxHeight, heights_167362_g83242.w);
				#endif
				float transition = max(heightTransition7362_g83242, 0.01);
				weightedHeights_04 = float4 ( heights_047362_g83242.x, heights_047362_g83242.y, heights_047362_g83242.z, heights_047362_g83242.w );
				weightedHeights_04 = weightedHeights_04 - maxHeight.xxxx;
				weightedHeights_04 = (max(0, weightedHeights_04 + transition) + 1e-6) * control_047362_g83242;
				#ifdef TVE_TERRAIN_08
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				#endif
				#ifdef TVE_TERRAIN_12
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				weightedHeights_12 = float4 ( heights_127362_g83242.x, heights_127362_g83242.y, heights_127362_g83242.z, heights_127362_g83242.w );
				weightedHeights_12 = weightedHeights_12 - maxHeight.xxxx;
				weightedHeights_12 = (max(0, weightedHeights_12 + transition) + 1e-6) * control_127362_g83242;
				#endif
				#ifdef TVE_TERRAIN_16
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				weightedHeights_12 = float4 ( heights_127362_g83242.x, heights_127362_g83242.y, heights_127362_g83242.z, heights_127362_g83242.w );
				weightedHeights_12 = weightedHeights_12 - maxHeight.xxxx;
				weightedHeights_12 = (max(0, weightedHeights_12 + transition) + 1e-6) * control_127362_g83242;
				weightedHeights_16 = float4 ( heights_167362_g83242.x, heights_167362_g83242.y, heights_167362_g83242.z, heights_167362_g83242.w );
				weightedHeights_16 = weightedHeights_16 - maxHeight.xxxx;
				weightedHeights_16 = (max(0, weightedHeights_16 + transition) + 1e-6) * control_167362_g83242;
				#endif
				float sumHeight_04 = weightedHeights_04.x + weightedHeights_04.y + weightedHeights_04.z + weightedHeights_04.w;
				float sumHeight_08 = weightedHeights_08.x + weightedHeights_08.y + weightedHeights_08.z + weightedHeights_08.w;
				float sumHeight_12 = weightedHeights_12.x + weightedHeights_12.y + weightedHeights_12.z + weightedHeights_12.w;
				float sumHeight_16 = weightedHeights_16.x + weightedHeights_16.y + weightedHeights_16.z + weightedHeights_16.w;
				float sumHeight = sumHeight_04 + sumHeight_08 + sumHeight_12 + sumHeight_16;
				weights_047362_g83242 = weightedHeights_04 / sumHeight.xxxx;
				#ifdef TVE_TERRAIN_08
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				#endif
				#ifdef TVE_TERRAIN_12
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				weights_127362_g83242 = weightedHeights_12 / sumHeight.xxxx;
				#endif
				#ifdef TVE_TERRAIN_16
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				weights_127362_g83242 = weightedHeights_12 / sumHeight.xxxx;
				weights_167362_g83242 = weightedHeights_16 / sumHeight.xxxx;
				#endif
				}
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8792_g83242 = weights_047362_g83242;
				#else
				float4 staticSwitch8792_g83242 = control_047362_g83242;
				#endif
				half4 Terrain_Weights_046781_g83242 = staticSwitch8792_g83242;
				half4 Weights52_g83255 = Terrain_Weights_046781_g83242;
				TEXTURE2D(Texture238_g83339) = _AlbedoTex1;
				SamplerState Sampler238_g83339 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83339 = Input_Coords_016785_g83242;
				half4 Coords238_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition238_g83339 = ase_worldPos;
				half4 localSamplePlanar2D238_g83339 = SamplePlanar2D( Texture238_g83339 , Sampler238_g83339 , Coords238_g83339 , WorldPosition238_g83339 );
				TEXTURE2D(Texture246_g83339) = _AlbedoTex1;
				SamplerState Sampler246_g83339 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition246_g83339 = ase_worldPos;
				half3 WorldNormal246_g83339 = normalWS;
				half4 localSamplePlanar3D246_g83339 = SamplePlanar3D( Texture246_g83339 , Sampler246_g83339 , Coords246_g83339 , WorldPosition246_g83339 , WorldNormal246_g83339 );
				TEXTURE2D(Texture234_g83339) = _AlbedoTex1;
				SamplerState Sampler234_g83339 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83339 = temp_output_37_0_g83339;
				float3 WorldPosition234_g83339 = ase_worldPos;
				float4 localSampleStochastic2D234_g83339 = SampleStochastic2D( Texture234_g83339 , Sampler234_g83339 , Coords234_g83339 , WorldPosition234_g83339 );
				TEXTURE2D(Texture263_g83339) = _AlbedoTex1;
				SamplerState Sampler263_g83339 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition263_g83339 = ase_worldPos;
				half3 WorldNormal263_g83339 = normalWS;
				half4 localSampleStochastic3D263_g83339 = SampleStochastic3D( Texture263_g83339 , Sampler263_g83339 , Coords263_g83339 , WorldPosition263_g83339 , WorldNormal263_g83339 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8614_g83242 = localSamplePlanar2D238_g83339;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8614_g83242 = localSamplePlanar3D246_g83339;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8614_g83242 = localSampleStochastic2D234_g83339;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8614_g83242 = localSampleStochastic3D263_g83339;
				#else
				float4 staticSwitch8614_g83242 = localSamplePlanar2D238_g83339;
				#endif
				half4 Layer133_g83255 = staticSwitch8614_g83242;
				TEXTURE2D(Texture238_g83292) = _AlbedoTex2;
				SamplerState Sampler238_g83292 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83292 = Input_Coords_026787_g83242;
				half4 Coords238_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition238_g83292 = ase_worldPos;
				half4 localSamplePlanar2D238_g83292 = SamplePlanar2D( Texture238_g83292 , Sampler238_g83292 , Coords238_g83292 , WorldPosition238_g83292 );
				TEXTURE2D(Texture246_g83292) = _AlbedoTex2;
				SamplerState Sampler246_g83292 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition246_g83292 = ase_worldPos;
				half3 WorldNormal246_g83292 = normalWS;
				half4 localSamplePlanar3D246_g83292 = SamplePlanar3D( Texture246_g83292 , Sampler246_g83292 , Coords246_g83292 , WorldPosition246_g83292 , WorldNormal246_g83292 );
				TEXTURE2D(Texture234_g83292) = _AlbedoTex2;
				SamplerState Sampler234_g83292 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83292 = temp_output_37_0_g83292;
				float3 WorldPosition234_g83292 = ase_worldPos;
				float4 localSampleStochastic2D234_g83292 = SampleStochastic2D( Texture234_g83292 , Sampler234_g83292 , Coords234_g83292 , WorldPosition234_g83292 );
				TEXTURE2D(Texture263_g83292) = _AlbedoTex2;
				SamplerState Sampler263_g83292 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition263_g83292 = ase_worldPos;
				half3 WorldNormal263_g83292 = normalWS;
				half4 localSampleStochastic3D263_g83292 = SampleStochastic3D( Texture263_g83292 , Sampler263_g83292 , Coords263_g83292 , WorldPosition263_g83292 , WorldNormal263_g83292 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8629_g83242 = localSamplePlanar2D238_g83292;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8629_g83242 = localSamplePlanar3D246_g83292;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8629_g83242 = localSampleStochastic2D234_g83292;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8629_g83242 = localSampleStochastic3D263_g83292;
				#else
				float4 staticSwitch8629_g83242 = localSamplePlanar2D238_g83292;
				#endif
				half4 Layer237_g83255 = staticSwitch8629_g83242;
				TEXTURE2D(Texture238_g83293) = _AlbedoTex3;
				SamplerState Sampler238_g83293 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83293 = Input_Coords_036789_g83242;
				half4 Coords238_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition238_g83293 = ase_worldPos;
				half4 localSamplePlanar2D238_g83293 = SamplePlanar2D( Texture238_g83293 , Sampler238_g83293 , Coords238_g83293 , WorldPosition238_g83293 );
				TEXTURE2D(Texture246_g83293) = _AlbedoTex3;
				SamplerState Sampler246_g83293 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition246_g83293 = ase_worldPos;
				half3 WorldNormal246_g83293 = normalWS;
				half4 localSamplePlanar3D246_g83293 = SamplePlanar3D( Texture246_g83293 , Sampler246_g83293 , Coords246_g83293 , WorldPosition246_g83293 , WorldNormal246_g83293 );
				TEXTURE2D(Texture234_g83293) = _AlbedoTex3;
				SamplerState Sampler234_g83293 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83293 = temp_output_37_0_g83293;
				float3 WorldPosition234_g83293 = ase_worldPos;
				float4 localSampleStochastic2D234_g83293 = SampleStochastic2D( Texture234_g83293 , Sampler234_g83293 , Coords234_g83293 , WorldPosition234_g83293 );
				TEXTURE2D(Texture263_g83293) = _AlbedoTex3;
				SamplerState Sampler263_g83293 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition263_g83293 = ase_worldPos;
				half3 WorldNormal263_g83293 = normalWS;
				half4 localSampleStochastic3D263_g83293 = SampleStochastic3D( Texture263_g83293 , Sampler263_g83293 , Coords263_g83293 , WorldPosition263_g83293 , WorldNormal263_g83293 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8630_g83242 = localSamplePlanar2D238_g83293;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8630_g83242 = localSamplePlanar3D246_g83293;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8630_g83242 = localSampleStochastic2D234_g83293;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8630_g83242 = localSampleStochastic3D263_g83293;
				#else
				float4 staticSwitch8630_g83242 = localSamplePlanar2D238_g83293;
				#endif
				half4 Layer338_g83255 = staticSwitch8630_g83242;
				TEXTURE2D(Texture238_g83294) = _AlbedoTex4;
				SamplerState Sampler238_g83294 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83294 = Input_Coords_046791_g83242;
				half4 Coords238_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition238_g83294 = ase_worldPos;
				half4 localSamplePlanar2D238_g83294 = SamplePlanar2D( Texture238_g83294 , Sampler238_g83294 , Coords238_g83294 , WorldPosition238_g83294 );
				TEXTURE2D(Texture246_g83294) = _AlbedoTex4;
				SamplerState Sampler246_g83294 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition246_g83294 = ase_worldPos;
				half3 WorldNormal246_g83294 = normalWS;
				half4 localSamplePlanar3D246_g83294 = SamplePlanar3D( Texture246_g83294 , Sampler246_g83294 , Coords246_g83294 , WorldPosition246_g83294 , WorldNormal246_g83294 );
				TEXTURE2D(Texture234_g83294) = _AlbedoTex4;
				SamplerState Sampler234_g83294 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83294 = temp_output_37_0_g83294;
				float3 WorldPosition234_g83294 = ase_worldPos;
				float4 localSampleStochastic2D234_g83294 = SampleStochastic2D( Texture234_g83294 , Sampler234_g83294 , Coords234_g83294 , WorldPosition234_g83294 );
				TEXTURE2D(Texture263_g83294) = _AlbedoTex4;
				SamplerState Sampler263_g83294 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition263_g83294 = ase_worldPos;
				half3 WorldNormal263_g83294 = normalWS;
				half4 localSampleStochastic3D263_g83294 = SampleStochastic3D( Texture263_g83294 , Sampler263_g83294 , Coords263_g83294 , WorldPosition263_g83294 , WorldNormal263_g83294 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8631_g83242 = localSamplePlanar2D238_g83294;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8631_g83242 = localSamplePlanar3D246_g83294;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8631_g83242 = localSampleStochastic2D234_g83294;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8631_g83242 = localSampleStochastic3D263_g83294;
				#else
				float4 staticSwitch8631_g83242 = localSamplePlanar2D238_g83294;
				#endif
				half4 Layer439_g83255 = staticSwitch8631_g83242;
				float4 weightedBlendVar31_g83255 = Weights52_g83255;
				float4 weightedBlend31_g83255 = ( weightedBlendVar31_g83255.x*Layer133_g83255 + weightedBlendVar31_g83255.y*Layer237_g83255 + weightedBlendVar31_g83255.z*Layer338_g83255 + weightedBlendVar31_g83255.w*Layer439_g83255 );
				half4 Terrain_Albedo_047200_g83242 = weightedBlend31_g83255;
				half4 Layer_045_g83258 = Terrain_Albedo_047200_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8793_g83242 = weights_087362_g83242;
				#else
				float4 staticSwitch8793_g83242 = control_087362_g83242;
				#endif
				half4 Terrain_Weights_087340_g83242 = staticSwitch8793_g83242;
				half4 Weights52_g83262 = Terrain_Weights_087340_g83242;
				TEXTURE2D(Texture238_g83303) = _AlbedoTex5;
				SamplerState Sampler238_g83303 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83303 = Input_Coords_058750_g83242;
				half4 Coords238_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition238_g83303 = ase_worldPos;
				half4 localSamplePlanar2D238_g83303 = SamplePlanar2D( Texture238_g83303 , Sampler238_g83303 , Coords238_g83303 , WorldPosition238_g83303 );
				TEXTURE2D(Texture246_g83303) = _AlbedoTex5;
				SamplerState Sampler246_g83303 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition246_g83303 = ase_worldPos;
				half3 WorldNormal246_g83303 = normalWS;
				half4 localSamplePlanar3D246_g83303 = SamplePlanar3D( Texture246_g83303 , Sampler246_g83303 , Coords246_g83303 , WorldPosition246_g83303 , WorldNormal246_g83303 );
				TEXTURE2D(Texture234_g83303) = _AlbedoTex5;
				SamplerState Sampler234_g83303 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83303 = temp_output_37_0_g83303;
				float3 WorldPosition234_g83303 = ase_worldPos;
				float4 localSampleStochastic2D234_g83303 = SampleStochastic2D( Texture234_g83303 , Sampler234_g83303 , Coords234_g83303 , WorldPosition234_g83303 );
				TEXTURE2D(Texture263_g83303) = _AlbedoTex5;
				SamplerState Sampler263_g83303 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition263_g83303 = ase_worldPos;
				half3 WorldNormal263_g83303 = normalWS;
				half4 localSampleStochastic3D263_g83303 = SampleStochastic3D( Texture263_g83303 , Sampler263_g83303 , Coords263_g83303 , WorldPosition263_g83303 , WorldNormal263_g83303 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8690_g83242 = localSamplePlanar2D238_g83303;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8690_g83242 = localSamplePlanar3D246_g83303;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8690_g83242 = localSampleStochastic2D234_g83303;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8690_g83242 = localSampleStochastic3D263_g83303;
				#else
				float4 staticSwitch8690_g83242 = localSamplePlanar2D238_g83303;
				#endif
				half4 Layer133_g83262 = staticSwitch8690_g83242;
				TEXTURE2D(Texture238_g83304) = _AlbedoTex6;
				SamplerState Sampler238_g83304 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83304 = Input_Coords_068751_g83242;
				half4 Coords238_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition238_g83304 = ase_worldPos;
				half4 localSamplePlanar2D238_g83304 = SamplePlanar2D( Texture238_g83304 , Sampler238_g83304 , Coords238_g83304 , WorldPosition238_g83304 );
				TEXTURE2D(Texture246_g83304) = _AlbedoTex6;
				SamplerState Sampler246_g83304 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition246_g83304 = ase_worldPos;
				half3 WorldNormal246_g83304 = normalWS;
				half4 localSamplePlanar3D246_g83304 = SamplePlanar3D( Texture246_g83304 , Sampler246_g83304 , Coords246_g83304 , WorldPosition246_g83304 , WorldNormal246_g83304 );
				TEXTURE2D(Texture234_g83304) = _AlbedoTex6;
				SamplerState Sampler234_g83304 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83304 = temp_output_37_0_g83304;
				float3 WorldPosition234_g83304 = ase_worldPos;
				float4 localSampleStochastic2D234_g83304 = SampleStochastic2D( Texture234_g83304 , Sampler234_g83304 , Coords234_g83304 , WorldPosition234_g83304 );
				TEXTURE2D(Texture263_g83304) = _AlbedoTex6;
				SamplerState Sampler263_g83304 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition263_g83304 = ase_worldPos;
				half3 WorldNormal263_g83304 = normalWS;
				half4 localSampleStochastic3D263_g83304 = SampleStochastic3D( Texture263_g83304 , Sampler263_g83304 , Coords263_g83304 , WorldPosition263_g83304 , WorldNormal263_g83304 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8691_g83242 = localSamplePlanar2D238_g83304;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8691_g83242 = localSamplePlanar3D246_g83304;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8691_g83242 = localSampleStochastic2D234_g83304;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8691_g83242 = localSampleStochastic3D263_g83304;
				#else
				float4 staticSwitch8691_g83242 = localSamplePlanar2D238_g83304;
				#endif
				half4 Layer237_g83262 = staticSwitch8691_g83242;
				TEXTURE2D(Texture238_g83305) = _AlbedoTex7;
				SamplerState Sampler238_g83305 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83305 = Input_Coords_078752_g83242;
				half4 Coords238_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition238_g83305 = ase_worldPos;
				half4 localSamplePlanar2D238_g83305 = SamplePlanar2D( Texture238_g83305 , Sampler238_g83305 , Coords238_g83305 , WorldPosition238_g83305 );
				TEXTURE2D(Texture246_g83305) = _AlbedoTex7;
				SamplerState Sampler246_g83305 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition246_g83305 = ase_worldPos;
				half3 WorldNormal246_g83305 = normalWS;
				half4 localSamplePlanar3D246_g83305 = SamplePlanar3D( Texture246_g83305 , Sampler246_g83305 , Coords246_g83305 , WorldPosition246_g83305 , WorldNormal246_g83305 );
				TEXTURE2D(Texture234_g83305) = _AlbedoTex7;
				SamplerState Sampler234_g83305 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83305 = temp_output_37_0_g83305;
				float3 WorldPosition234_g83305 = ase_worldPos;
				float4 localSampleStochastic2D234_g83305 = SampleStochastic2D( Texture234_g83305 , Sampler234_g83305 , Coords234_g83305 , WorldPosition234_g83305 );
				TEXTURE2D(Texture263_g83305) = _AlbedoTex7;
				SamplerState Sampler263_g83305 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition263_g83305 = ase_worldPos;
				half3 WorldNormal263_g83305 = normalWS;
				half4 localSampleStochastic3D263_g83305 = SampleStochastic3D( Texture263_g83305 , Sampler263_g83305 , Coords263_g83305 , WorldPosition263_g83305 , WorldNormal263_g83305 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8692_g83242 = localSamplePlanar2D238_g83305;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8692_g83242 = localSamplePlanar3D246_g83305;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8692_g83242 = localSampleStochastic2D234_g83305;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8692_g83242 = localSampleStochastic3D263_g83305;
				#else
				float4 staticSwitch8692_g83242 = localSamplePlanar2D238_g83305;
				#endif
				half4 Layer338_g83262 = staticSwitch8692_g83242;
				TEXTURE2D(Texture238_g83306) = _AlbedoTex8;
				SamplerState Sampler238_g83306 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83306 = Input_Coords_088749_g83242;
				half4 Coords238_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition238_g83306 = ase_worldPos;
				half4 localSamplePlanar2D238_g83306 = SamplePlanar2D( Texture238_g83306 , Sampler238_g83306 , Coords238_g83306 , WorldPosition238_g83306 );
				TEXTURE2D(Texture246_g83306) = _AlbedoTex8;
				SamplerState Sampler246_g83306 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition246_g83306 = ase_worldPos;
				half3 WorldNormal246_g83306 = normalWS;
				half4 localSamplePlanar3D246_g83306 = SamplePlanar3D( Texture246_g83306 , Sampler246_g83306 , Coords246_g83306 , WorldPosition246_g83306 , WorldNormal246_g83306 );
				TEXTURE2D(Texture234_g83306) = _AlbedoTex8;
				SamplerState Sampler234_g83306 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83306 = temp_output_37_0_g83306;
				float3 WorldPosition234_g83306 = ase_worldPos;
				float4 localSampleStochastic2D234_g83306 = SampleStochastic2D( Texture234_g83306 , Sampler234_g83306 , Coords234_g83306 , WorldPosition234_g83306 );
				TEXTURE2D(Texture263_g83306) = _AlbedoTex8;
				SamplerState Sampler263_g83306 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition263_g83306 = ase_worldPos;
				half3 WorldNormal263_g83306 = normalWS;
				half4 localSampleStochastic3D263_g83306 = SampleStochastic3D( Texture263_g83306 , Sampler263_g83306 , Coords263_g83306 , WorldPosition263_g83306 , WorldNormal263_g83306 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8693_g83242 = localSamplePlanar2D238_g83306;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8693_g83242 = localSamplePlanar3D246_g83306;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8693_g83242 = localSampleStochastic2D234_g83306;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8693_g83242 = localSampleStochastic3D263_g83306;
				#else
				float4 staticSwitch8693_g83242 = localSamplePlanar2D238_g83306;
				#endif
				half4 Layer439_g83262 = staticSwitch8693_g83242;
				float4 weightedBlendVar31_g83262 = Weights52_g83262;
				float4 weightedBlend31_g83262 = ( weightedBlendVar31_g83262.x*Layer133_g83262 + weightedBlendVar31_g83262.y*Layer237_g83262 + weightedBlendVar31_g83262.z*Layer338_g83262 + weightedBlendVar31_g83262.w*Layer439_g83262 );
				half4 Terrain_Albedo_088665_g83242 = weightedBlend31_g83262;
				half4 Layer_0810_g83258 = Terrain_Albedo_088665_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8794_g83242 = weights_127362_g83242;
				#else
				float4 staticSwitch8794_g83242 = control_127362_g83242;
				#endif
				half4 Terrain_Weights_127710_g83242 = staticSwitch8794_g83242;
				half4 Weights52_g83272 = Terrain_Weights_127710_g83242;
				TEXTURE2D(Texture238_g83315) = _AlbedoTex9;
				SamplerState Sampler238_g83315 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83315 = Input_Coords_098833_g83242;
				half4 Coords238_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition238_g83315 = ase_worldPos;
				half4 localSamplePlanar2D238_g83315 = SamplePlanar2D( Texture238_g83315 , Sampler238_g83315 , Coords238_g83315 , WorldPosition238_g83315 );
				TEXTURE2D(Texture246_g83315) = _AlbedoTex9;
				SamplerState Sampler246_g83315 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition246_g83315 = ase_worldPos;
				half3 WorldNormal246_g83315 = normalWS;
				half4 localSamplePlanar3D246_g83315 = SamplePlanar3D( Texture246_g83315 , Sampler246_g83315 , Coords246_g83315 , WorldPosition246_g83315 , WorldNormal246_g83315 );
				TEXTURE2D(Texture234_g83315) = _AlbedoTex9;
				SamplerState Sampler234_g83315 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83315 = temp_output_37_0_g83315;
				float3 WorldPosition234_g83315 = ase_worldPos;
				float4 localSampleStochastic2D234_g83315 = SampleStochastic2D( Texture234_g83315 , Sampler234_g83315 , Coords234_g83315 , WorldPosition234_g83315 );
				TEXTURE2D(Texture263_g83315) = _AlbedoTex9;
				SamplerState Sampler263_g83315 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition263_g83315 = ase_worldPos;
				half3 WorldNormal263_g83315 = normalWS;
				half4 localSampleStochastic3D263_g83315 = SampleStochastic3D( Texture263_g83315 , Sampler263_g83315 , Coords263_g83315 , WorldPosition263_g83315 , WorldNormal263_g83315 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8872_g83242 = localSamplePlanar2D238_g83315;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8872_g83242 = localSamplePlanar3D246_g83315;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8872_g83242 = localSampleStochastic2D234_g83315;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8872_g83242 = localSampleStochastic3D263_g83315;
				#else
				float4 staticSwitch8872_g83242 = localSamplePlanar2D238_g83315;
				#endif
				half4 Layer133_g83272 = staticSwitch8872_g83242;
				TEXTURE2D(Texture238_g83316) = _AlbedoTex10;
				SamplerState Sampler238_g83316 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83316 = Input_Coords_108834_g83242;
				half4 Coords238_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition238_g83316 = ase_worldPos;
				half4 localSamplePlanar2D238_g83316 = SamplePlanar2D( Texture238_g83316 , Sampler238_g83316 , Coords238_g83316 , WorldPosition238_g83316 );
				TEXTURE2D(Texture246_g83316) = _AlbedoTex10;
				SamplerState Sampler246_g83316 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition246_g83316 = ase_worldPos;
				half3 WorldNormal246_g83316 = normalWS;
				half4 localSamplePlanar3D246_g83316 = SamplePlanar3D( Texture246_g83316 , Sampler246_g83316 , Coords246_g83316 , WorldPosition246_g83316 , WorldNormal246_g83316 );
				TEXTURE2D(Texture234_g83316) = _AlbedoTex10;
				SamplerState Sampler234_g83316 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83316 = temp_output_37_0_g83316;
				float3 WorldPosition234_g83316 = ase_worldPos;
				float4 localSampleStochastic2D234_g83316 = SampleStochastic2D( Texture234_g83316 , Sampler234_g83316 , Coords234_g83316 , WorldPosition234_g83316 );
				TEXTURE2D(Texture263_g83316) = _AlbedoTex10;
				SamplerState Sampler263_g83316 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition263_g83316 = ase_worldPos;
				half3 WorldNormal263_g83316 = normalWS;
				half4 localSampleStochastic3D263_g83316 = SampleStochastic3D( Texture263_g83316 , Sampler263_g83316 , Coords263_g83316 , WorldPosition263_g83316 , WorldNormal263_g83316 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8873_g83242 = localSamplePlanar2D238_g83316;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8873_g83242 = localSamplePlanar3D246_g83316;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8873_g83242 = localSampleStochastic2D234_g83316;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8873_g83242 = localSampleStochastic3D263_g83316;
				#else
				float4 staticSwitch8873_g83242 = localSamplePlanar2D238_g83316;
				#endif
				half4 Layer237_g83272 = staticSwitch8873_g83242;
				TEXTURE2D(Texture238_g83317) = _AlbedoTex11;
				SamplerState Sampler238_g83317 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83317 = Input_Coords_118835_g83242;
				half4 Coords238_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition238_g83317 = ase_worldPos;
				half4 localSamplePlanar2D238_g83317 = SamplePlanar2D( Texture238_g83317 , Sampler238_g83317 , Coords238_g83317 , WorldPosition238_g83317 );
				TEXTURE2D(Texture246_g83317) = _AlbedoTex11;
				SamplerState Sampler246_g83317 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition246_g83317 = ase_worldPos;
				half3 WorldNormal246_g83317 = normalWS;
				half4 localSamplePlanar3D246_g83317 = SamplePlanar3D( Texture246_g83317 , Sampler246_g83317 , Coords246_g83317 , WorldPosition246_g83317 , WorldNormal246_g83317 );
				TEXTURE2D(Texture234_g83317) = _AlbedoTex11;
				SamplerState Sampler234_g83317 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83317 = temp_output_37_0_g83317;
				float3 WorldPosition234_g83317 = ase_worldPos;
				float4 localSampleStochastic2D234_g83317 = SampleStochastic2D( Texture234_g83317 , Sampler234_g83317 , Coords234_g83317 , WorldPosition234_g83317 );
				TEXTURE2D(Texture263_g83317) = _AlbedoTex11;
				SamplerState Sampler263_g83317 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition263_g83317 = ase_worldPos;
				half3 WorldNormal263_g83317 = normalWS;
				half4 localSampleStochastic3D263_g83317 = SampleStochastic3D( Texture263_g83317 , Sampler263_g83317 , Coords263_g83317 , WorldPosition263_g83317 , WorldNormal263_g83317 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8874_g83242 = localSamplePlanar2D238_g83317;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8874_g83242 = localSamplePlanar3D246_g83317;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8874_g83242 = localSampleStochastic2D234_g83317;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8874_g83242 = localSampleStochastic3D263_g83317;
				#else
				float4 staticSwitch8874_g83242 = localSamplePlanar2D238_g83317;
				#endif
				half4 Layer338_g83272 = staticSwitch8874_g83242;
				TEXTURE2D(Texture238_g83318) = _AlbedoTex12;
				SamplerState Sampler238_g83318 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83318 = Input_Coords_128836_g83242;
				half4 Coords238_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition238_g83318 = ase_worldPos;
				half4 localSamplePlanar2D238_g83318 = SamplePlanar2D( Texture238_g83318 , Sampler238_g83318 , Coords238_g83318 , WorldPosition238_g83318 );
				TEXTURE2D(Texture246_g83318) = _AlbedoTex12;
				SamplerState Sampler246_g83318 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition246_g83318 = ase_worldPos;
				half3 WorldNormal246_g83318 = normalWS;
				half4 localSamplePlanar3D246_g83318 = SamplePlanar3D( Texture246_g83318 , Sampler246_g83318 , Coords246_g83318 , WorldPosition246_g83318 , WorldNormal246_g83318 );
				TEXTURE2D(Texture234_g83318) = _AlbedoTex12;
				SamplerState Sampler234_g83318 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83318 = temp_output_37_0_g83318;
				float3 WorldPosition234_g83318 = ase_worldPos;
				float4 localSampleStochastic2D234_g83318 = SampleStochastic2D( Texture234_g83318 , Sampler234_g83318 , Coords234_g83318 , WorldPosition234_g83318 );
				TEXTURE2D(Texture263_g83318) = _AlbedoTex12;
				SamplerState Sampler263_g83318 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition263_g83318 = ase_worldPos;
				half3 WorldNormal263_g83318 = normalWS;
				half4 localSampleStochastic3D263_g83318 = SampleStochastic3D( Texture263_g83318 , Sampler263_g83318 , Coords263_g83318 , WorldPosition263_g83318 , WorldNormal263_g83318 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8875_g83242 = localSamplePlanar2D238_g83318;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8875_g83242 = localSamplePlanar3D246_g83318;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8875_g83242 = localSampleStochastic2D234_g83318;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8875_g83242 = localSampleStochastic3D263_g83318;
				#else
				float4 staticSwitch8875_g83242 = localSamplePlanar2D238_g83318;
				#endif
				half4 Layer439_g83272 = staticSwitch8875_g83242;
				float4 weightedBlendVar31_g83272 = Weights52_g83272;
				float4 weightedBlend31_g83272 = ( weightedBlendVar31_g83272.x*Layer133_g83272 + weightedBlendVar31_g83272.y*Layer237_g83272 + weightedBlendVar31_g83272.z*Layer338_g83272 + weightedBlendVar31_g83272.w*Layer439_g83272 );
				half4 Terrain_Albedo_128851_g83242 = weightedBlend31_g83272;
				half4 Layer_1243_g83258 = Terrain_Albedo_128851_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8795_g83242 = weights_167362_g83242;
				#else
				float4 staticSwitch8795_g83242 = control_167362_g83242;
				#endif
				half4 Terrain_Weights_167709_g83242 = staticSwitch8795_g83242;
				half4 Weights52_g83282 = Terrain_Weights_167709_g83242;
				TEXTURE2D(Texture238_g83327) = _AlbedoTex13;
				SamplerState Sampler238_g83327 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83327 = Input_Coords_138960_g83242;
				half4 Coords238_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition238_g83327 = ase_worldPos;
				half4 localSamplePlanar2D238_g83327 = SamplePlanar2D( Texture238_g83327 , Sampler238_g83327 , Coords238_g83327 , WorldPosition238_g83327 );
				TEXTURE2D(Texture246_g83327) = _AlbedoTex13;
				SamplerState Sampler246_g83327 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition246_g83327 = ase_worldPos;
				half3 WorldNormal246_g83327 = normalWS;
				half4 localSamplePlanar3D246_g83327 = SamplePlanar3D( Texture246_g83327 , Sampler246_g83327 , Coords246_g83327 , WorldPosition246_g83327 , WorldNormal246_g83327 );
				TEXTURE2D(Texture234_g83327) = _AlbedoTex13;
				SamplerState Sampler234_g83327 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83327 = temp_output_37_0_g83327;
				float3 WorldPosition234_g83327 = ase_worldPos;
				float4 localSampleStochastic2D234_g83327 = SampleStochastic2D( Texture234_g83327 , Sampler234_g83327 , Coords234_g83327 , WorldPosition234_g83327 );
				TEXTURE2D(Texture263_g83327) = _AlbedoTex13;
				SamplerState Sampler263_g83327 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition263_g83327 = ase_worldPos;
				half3 WorldNormal263_g83327 = normalWS;
				half4 localSampleStochastic3D263_g83327 = SampleStochastic3D( Texture263_g83327 , Sampler263_g83327 , Coords263_g83327 , WorldPosition263_g83327 , WorldNormal263_g83327 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch8972_g83242 = localSamplePlanar2D238_g83327;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch8972_g83242 = localSamplePlanar3D246_g83327;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch8972_g83242 = localSampleStochastic2D234_g83327;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch8972_g83242 = localSampleStochastic3D263_g83327;
				#else
				float4 staticSwitch8972_g83242 = localSamplePlanar2D238_g83327;
				#endif
				half4 Layer133_g83282 = staticSwitch8972_g83242;
				TEXTURE2D(Texture238_g83328) = _AlbedoTex14;
				SamplerState Sampler238_g83328 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83328 = Input_Coords_148961_g83242;
				half4 Coords238_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition238_g83328 = ase_worldPos;
				half4 localSamplePlanar2D238_g83328 = SamplePlanar2D( Texture238_g83328 , Sampler238_g83328 , Coords238_g83328 , WorldPosition238_g83328 );
				TEXTURE2D(Texture246_g83328) = _AlbedoTex14;
				SamplerState Sampler246_g83328 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition246_g83328 = ase_worldPos;
				half3 WorldNormal246_g83328 = normalWS;
				half4 localSamplePlanar3D246_g83328 = SamplePlanar3D( Texture246_g83328 , Sampler246_g83328 , Coords246_g83328 , WorldPosition246_g83328 , WorldNormal246_g83328 );
				TEXTURE2D(Texture234_g83328) = _AlbedoTex14;
				SamplerState Sampler234_g83328 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83328 = temp_output_37_0_g83328;
				float3 WorldPosition234_g83328 = ase_worldPos;
				float4 localSampleStochastic2D234_g83328 = SampleStochastic2D( Texture234_g83328 , Sampler234_g83328 , Coords234_g83328 , WorldPosition234_g83328 );
				TEXTURE2D(Texture263_g83328) = _AlbedoTex14;
				SamplerState Sampler263_g83328 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition263_g83328 = ase_worldPos;
				half3 WorldNormal263_g83328 = normalWS;
				half4 localSampleStochastic3D263_g83328 = SampleStochastic3D( Texture263_g83328 , Sampler263_g83328 , Coords263_g83328 , WorldPosition263_g83328 , WorldNormal263_g83328 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch8973_g83242 = localSamplePlanar2D238_g83328;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch8973_g83242 = localSamplePlanar3D246_g83328;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch8973_g83242 = localSampleStochastic2D234_g83328;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch8973_g83242 = localSampleStochastic3D263_g83328;
				#else
				float4 staticSwitch8973_g83242 = localSamplePlanar2D238_g83328;
				#endif
				half4 Layer237_g83282 = staticSwitch8973_g83242;
				TEXTURE2D(Texture238_g83329) = _AlbedoTex15;
				SamplerState Sampler238_g83329 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83329 = Input_Coords_158962_g83242;
				half4 Coords238_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition238_g83329 = ase_worldPos;
				half4 localSamplePlanar2D238_g83329 = SamplePlanar2D( Texture238_g83329 , Sampler238_g83329 , Coords238_g83329 , WorldPosition238_g83329 );
				TEXTURE2D(Texture246_g83329) = _AlbedoTex15;
				SamplerState Sampler246_g83329 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition246_g83329 = ase_worldPos;
				half3 WorldNormal246_g83329 = normalWS;
				half4 localSamplePlanar3D246_g83329 = SamplePlanar3D( Texture246_g83329 , Sampler246_g83329 , Coords246_g83329 , WorldPosition246_g83329 , WorldNormal246_g83329 );
				TEXTURE2D(Texture234_g83329) = _AlbedoTex15;
				SamplerState Sampler234_g83329 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83329 = temp_output_37_0_g83329;
				float3 WorldPosition234_g83329 = ase_worldPos;
				float4 localSampleStochastic2D234_g83329 = SampleStochastic2D( Texture234_g83329 , Sampler234_g83329 , Coords234_g83329 , WorldPosition234_g83329 );
				TEXTURE2D(Texture263_g83329) = _AlbedoTex15;
				SamplerState Sampler263_g83329 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition263_g83329 = ase_worldPos;
				half3 WorldNormal263_g83329 = normalWS;
				half4 localSampleStochastic3D263_g83329 = SampleStochastic3D( Texture263_g83329 , Sampler263_g83329 , Coords263_g83329 , WorldPosition263_g83329 , WorldNormal263_g83329 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch8974_g83242 = localSamplePlanar2D238_g83329;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch8974_g83242 = localSamplePlanar3D246_g83329;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch8974_g83242 = localSampleStochastic2D234_g83329;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch8974_g83242 = localSampleStochastic3D263_g83329;
				#else
				float4 staticSwitch8974_g83242 = localSamplePlanar2D238_g83329;
				#endif
				half4 Layer338_g83282 = staticSwitch8974_g83242;
				TEXTURE2D(Texture238_g83330) = _AlbedoTex16;
				SamplerState Sampler238_g83330 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83330 = Input_Coords_168959_g83242;
				half4 Coords238_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition238_g83330 = ase_worldPos;
				half4 localSamplePlanar2D238_g83330 = SamplePlanar2D( Texture238_g83330 , Sampler238_g83330 , Coords238_g83330 , WorldPosition238_g83330 );
				TEXTURE2D(Texture246_g83330) = _AlbedoTex16;
				SamplerState Sampler246_g83330 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition246_g83330 = ase_worldPos;
				half3 WorldNormal246_g83330 = normalWS;
				half4 localSamplePlanar3D246_g83330 = SamplePlanar3D( Texture246_g83330 , Sampler246_g83330 , Coords246_g83330 , WorldPosition246_g83330 , WorldNormal246_g83330 );
				TEXTURE2D(Texture234_g83330) = _AlbedoTex16;
				SamplerState Sampler234_g83330 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83330 = temp_output_37_0_g83330;
				float3 WorldPosition234_g83330 = ase_worldPos;
				float4 localSampleStochastic2D234_g83330 = SampleStochastic2D( Texture234_g83330 , Sampler234_g83330 , Coords234_g83330 , WorldPosition234_g83330 );
				TEXTURE2D(Texture263_g83330) = _AlbedoTex16;
				SamplerState Sampler263_g83330 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition263_g83330 = ase_worldPos;
				half3 WorldNormal263_g83330 = normalWS;
				half4 localSampleStochastic3D263_g83330 = SampleStochastic3D( Texture263_g83330 , Sampler263_g83330 , Coords263_g83330 , WorldPosition263_g83330 , WorldNormal263_g83330 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch8975_g83242 = localSamplePlanar2D238_g83330;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch8975_g83242 = localSamplePlanar3D246_g83330;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch8975_g83242 = localSampleStochastic2D234_g83330;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch8975_g83242 = localSampleStochastic3D263_g83330;
				#else
				float4 staticSwitch8975_g83242 = localSamplePlanar2D238_g83330;
				#endif
				half4 Layer439_g83282 = staticSwitch8975_g83242;
				float4 weightedBlendVar31_g83282 = Weights52_g83282;
				float4 weightedBlend31_g83282 = ( weightedBlendVar31_g83282.x*Layer133_g83282 + weightedBlendVar31_g83282.y*Layer237_g83282 + weightedBlendVar31_g83282.z*Layer338_g83282 + weightedBlendVar31_g83282.w*Layer439_g83282 );
				half4 Terrain_Albedo_168986_g83242 = weightedBlend31_g83282;
				half4 Layer_1644_g83258 = Terrain_Albedo_168986_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83258 = Layer_045_g83258;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 + Layer_1243_g83258 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 + Layer_1243_g83258 + Layer_1644_g83258 );
				#else
				float4 staticSwitch40_g83258 = Layer_045_g83258;
				#endif
				half4 Blend_Albedo7468_g83242 = staticSwitch40_g83258;
				half4 Terrain_Albedo6800_g79798 = Blend_Albedo7468_g83242;
				half3 Blend_Albedo2808_g79798 = ( (Terrain_Albedo6800_g79798).xyz * (_TerrainColor).rgb );
				half3 Blend_Albedo_Tinted7319_g79798 = Blend_Albedo2808_g79798;
				float3 temp_output_3_0_g79843 = Blend_Albedo2808_g79798;
				float dotResult20_g79843 = dot( temp_output_3_0_g79843 , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Grayscale5939_g79798 = dotResult20_g79843;
				float3 temp_cast_8 = (Blend_Albedo_Grayscale5939_g79798).xxx;
				float temp_output_82_0_g79821 = _LayerColorsValue;
				float temp_output_19_0_g79825 = TVE_ColorsUsage[(int)temp_output_82_0_g79821];
				float4 temp_output_91_19_g79821 = TVE_ColorsCoords;
				float3 vertexToFrag7344_g79798 = packedInput.ase_texcoord6.xyz;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV94_g79821 = ( (temp_output_91_19_g79821).zw + ( (temp_output_91_19_g79821).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode83_g79821 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, UV94_g79821,temp_output_82_0_g79821, 0.0 );
				float4 temp_output_17_0_g79825 = tex2DArrayNode83_g79821;
				float4 temp_output_92_86_g79821 = TVE_ColorsParams;
				float4 temp_output_3_0_g79825 = temp_output_92_86_g79821;
				float4 ifLocalVar18_g79825 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79825 >= 0.5 )
				ifLocalVar18_g79825 = temp_output_17_0_g79825;
				else
				ifLocalVar18_g79825 = temp_output_3_0_g79825;
				float4 lerpResult22_g79825 = lerp( temp_output_3_0_g79825 , temp_output_17_0_g79825 , temp_output_19_0_g79825);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79825 = lerpResult22_g79825;
				#else
				float4 staticSwitch24_g79825 = ifLocalVar18_g79825;
				#endif
				half4 Global_Colors_Params5434_g79798 = staticSwitch24_g79825;
				float4 temp_output_346_0_g79804 = Global_Colors_Params5434_g79798;
				half Global_Colors_A1701_g79798 = saturate( (temp_output_346_0_g79804).w );
				half Colors_Influence3668_g79798 = Global_Colors_A1701_g79798;
				float temp_output_6306_0_g79798 = ( 1.0 - Colors_Influence3668_g79798 );
				float3 lerpResult3618_g79798 = lerp( Blend_Albedo_Tinted7319_g79798 , temp_cast_8 , ( 1.0 - ( temp_output_6306_0_g79798 * temp_output_6306_0_g79798 ) ));
				half3 Global_Colors_RGB1700_g79798 = (temp_output_346_0_g79804).xyz;
				half3 Colors_RGB1954_g79798 = ( Global_Colors_RGB1700_g79798 * 4.594794 * _ColorsIntensityValue );
				half4 Weights52_g83254 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83254 = _Specular1;
				half4 Layer237_g83254 = _Specular2;
				half4 Layer338_g83254 = _Specular3;
				half4 Layer439_g83254 = _Specular4;
				float4 weightedBlendVar31_g83254 = Weights52_g83254;
				float4 weightedBlend31_g83254 = ( weightedBlendVar31_g83254.x*Layer133_g83254 + weightedBlendVar31_g83254.y*Layer237_g83254 + weightedBlendVar31_g83254.z*Layer338_g83254 + weightedBlendVar31_g83254.w*Layer439_g83254 );
				half4 Terrain_Specular_047390_g83242 = weightedBlend31_g83254;
				half4 Layer_045_g83261 = Terrain_Specular_047390_g83242;
				half4 Weights52_g83271 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83271 = _Specular5;
				half4 Layer237_g83271 = _Specular6;
				half4 Layer338_g83271 = _Specular7;
				half4 Layer439_g83271 = _Specular8;
				float4 weightedBlendVar31_g83271 = Weights52_g83271;
				float4 weightedBlend31_g83271 = ( weightedBlendVar31_g83271.x*Layer133_g83271 + weightedBlendVar31_g83271.y*Layer237_g83271 + weightedBlendVar31_g83271.z*Layer338_g83271 + weightedBlendVar31_g83271.w*Layer439_g83271 );
				half4 Terrain_Specular_088745_g83242 = weightedBlend31_g83271;
				half4 Layer_0810_g83261 = Terrain_Specular_088745_g83242;
				half4 Weights52_g83281 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83281 = _Specular9;
				half4 Layer237_g83281 = _Specular10;
				half4 Layer338_g83281 = _Specular11;
				half4 Layer439_g83281 = _Specular12;
				float4 weightedBlendVar31_g83281 = Weights52_g83281;
				float4 weightedBlend31_g83281 = ( weightedBlendVar31_g83281.x*Layer133_g83281 + weightedBlendVar31_g83281.y*Layer237_g83281 + weightedBlendVar31_g83281.z*Layer338_g83281 + weightedBlendVar31_g83281.w*Layer439_g83281 );
				half4 Terrain_Specular_128869_g83242 = weightedBlend31_g83281;
				half4 Layer_1243_g83261 = Terrain_Specular_128869_g83242;
				half4 Weights52_g83291 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83291 = _Specular13;
				half4 Layer237_g83291 = _Specular14;
				half4 Layer338_g83291 = _Specular15;
				half4 Layer439_g83291 = _Specular16;
				float4 weightedBlendVar31_g83291 = Weights52_g83291;
				float4 weightedBlend31_g83291 = ( weightedBlendVar31_g83291.x*Layer133_g83291 + weightedBlendVar31_g83291.y*Layer237_g83291 + weightedBlendVar31_g83291.z*Layer338_g83291 + weightedBlendVar31_g83291.w*Layer439_g83291 );
				half4 Terrain_Specular_169019_g83242 = weightedBlend31_g83291;
				half4 Layer_1644_g83261 = Terrain_Specular_169019_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83261 = Layer_045_g83261;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 + Layer_1243_g83261 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 + Layer_1243_g83261 + Layer_1644_g83261 );
				#else
				float4 staticSwitch40_g83261 = Layer_045_g83261;
				#endif
				half4 Blend_Specular7446_g83242 = staticSwitch40_g83261;
				half4 Terrain_Specular7322_g79798 = Blend_Specular7446_g83242;
				half Colors_Value3692_g79798 = ( (Terrain_Albedo6800_g79798).w * _GlobalColors * (Terrain_Specular7322_g79798).a );
				float clampResult6740_g79798 = clamp( saturate( ( Blend_Albedo_Grayscale5939_g79798 * 5.0 ) ) , 0.2 , 1.0 );
				half Blend_Albedo_Globals6410_g79798 = clampResult6740_g79798;
				float temp_output_7_0_g79846 = 0.1;
				float temp_output_10_0_g79846 = ( 0.2 - temp_output_7_0_g79846 );
				float lerpResult16_g79845 = lerp( 0.0 , saturate( ( ( ( Colors_Value3692_g79798 * Colors_Influence3668_g79798 * Blend_Albedo_Globals6410_g79798 ) - temp_output_7_0_g79846 ) / ( temp_output_10_0_g79846 + 0.0001 ) ) ) , TVE_IsEnabled);
				float3 lerpResult3628_g79798 = lerp( Blend_Albedo_Tinted7319_g79798 , ( lerpResult3618_g79798 * Colors_RGB1954_g79798 ) , lerpResult16_g79845);
				half3 Blend_Albedo_Colored_High6027_g79798 = lerpResult3628_g79798;
				half3 Blend_Albedo_Colored863_g79798 = Blend_Albedo_Colored_High6027_g79798;
				half3 Global_OverlayColor1758_g79798 = (TVE_OverlayColor).rgb;
				float temp_output_84_0_g79816 = _LayerExtrasValue;
				float temp_output_19_0_g79820 = TVE_ExtrasUsage[(int)temp_output_84_0_g79816];
				float4 temp_output_93_19_g79816 = TVE_ExtrasCoords;
				half2 UV96_g79816 = ( (temp_output_93_19_g79816).zw + ( (temp_output_93_19_g79816).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode48_g79816 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g79816,temp_output_84_0_g79816, 0.0 );
				float4 temp_output_17_0_g79820 = tex2DArrayNode48_g79816;
				float4 temp_output_94_85_g79816 = TVE_ExtrasParams;
				float4 temp_output_3_0_g79820 = temp_output_94_85_g79816;
				float4 ifLocalVar18_g79820 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79820 >= 0.5 )
				ifLocalVar18_g79820 = temp_output_17_0_g79820;
				else
				ifLocalVar18_g79820 = temp_output_3_0_g79820;
				float4 lerpResult22_g79820 = lerp( temp_output_3_0_g79820 , temp_output_17_0_g79820 , temp_output_19_0_g79820);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79820 = lerpResult22_g79820;
				#else
				float4 staticSwitch24_g79820 = ifLocalVar18_g79820;
				#endif
				half4 Global_Extras_Params5440_g79798 = staticSwitch24_g79820;
				float4 break456_g79805 = Global_Extras_Params5440_g79798;
				half Global_Extras_Overlay156_g79798 = break456_g79805.z;
				half Overlay_Value5738_g79798 = ( _GlobalOverlay * Global_Extras_Overlay156_g79798 );
				float3 ase_worldBitangent = packedInput.ase_texcoord7.xyz;
				float3x3 ase_worldToTangent = float3x3(tangentWS.xyz,ase_worldBitangent,normalWS);
				half4 Weights52_g83247 = Terrain_Weights_046781_g83242;
				TEXTURE2D(Texture238_g83295) = _NormalTex1;
				SamplerState Sampler238_g83295 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83295 = Input_Coords_016785_g83242;
				half4 Coords238_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition238_g83295 = ase_worldPos;
				half4 localSamplePlanar2D238_g83295 = SamplePlanar2D( Texture238_g83295 , Sampler238_g83295 , Coords238_g83295 , WorldPosition238_g83295 );
				TEXTURE2D(Texture246_g83295) = _NormalTex1;
				SamplerState Sampler246_g83295 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition246_g83295 = ase_worldPos;
				half3 WorldNormal246_g83295 = normalWS;
				half4 localSamplePlanar3D246_g83295 = SamplePlanar3D( Texture246_g83295 , Sampler246_g83295 , Coords246_g83295 , WorldPosition246_g83295 , WorldNormal246_g83295 );
				TEXTURE2D(Texture234_g83295) = _NormalTex1;
				SamplerState Sampler234_g83295 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83295 = temp_output_37_0_g83295;
				float3 WorldPosition234_g83295 = ase_worldPos;
				float4 localSampleStochastic2D234_g83295 = SampleStochastic2D( Texture234_g83295 , Sampler234_g83295 , Coords234_g83295 , WorldPosition234_g83295 );
				TEXTURE2D(Texture263_g83295) = _NormalTex1;
				SamplerState Sampler263_g83295 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition263_g83295 = ase_worldPos;
				half3 WorldNormal263_g83295 = normalWS;
				half4 localSampleStochastic3D263_g83295 = SampleStochastic3D( Texture263_g83295 , Sampler263_g83295 , Coords263_g83295 , WorldPosition263_g83295 , WorldNormal263_g83295 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8635_g83242 = localSamplePlanar2D238_g83295;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8635_g83242 = localSamplePlanar3D246_g83295;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8635_g83242 = localSampleStochastic2D234_g83295;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8635_g83242 = localSampleStochastic3D263_g83295;
				#else
				float4 staticSwitch8635_g83242 = localSamplePlanar2D238_g83295;
				#endif
				half4 Layer133_g83247 = staticSwitch8635_g83242;
				TEXTURE2D(Texture238_g83296) = _NormalTex2;
				SamplerState Sampler238_g83296 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83296 = Input_Coords_026787_g83242;
				half4 Coords238_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition238_g83296 = ase_worldPos;
				half4 localSamplePlanar2D238_g83296 = SamplePlanar2D( Texture238_g83296 , Sampler238_g83296 , Coords238_g83296 , WorldPosition238_g83296 );
				TEXTURE2D(Texture246_g83296) = _NormalTex2;
				SamplerState Sampler246_g83296 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition246_g83296 = ase_worldPos;
				half3 WorldNormal246_g83296 = normalWS;
				half4 localSamplePlanar3D246_g83296 = SamplePlanar3D( Texture246_g83296 , Sampler246_g83296 , Coords246_g83296 , WorldPosition246_g83296 , WorldNormal246_g83296 );
				TEXTURE2D(Texture234_g83296) = _NormalTex2;
				SamplerState Sampler234_g83296 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83296 = temp_output_37_0_g83296;
				float3 WorldPosition234_g83296 = ase_worldPos;
				float4 localSampleStochastic2D234_g83296 = SampleStochastic2D( Texture234_g83296 , Sampler234_g83296 , Coords234_g83296 , WorldPosition234_g83296 );
				TEXTURE2D(Texture263_g83296) = _NormalTex2;
				SamplerState Sampler263_g83296 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition263_g83296 = ase_worldPos;
				half3 WorldNormal263_g83296 = normalWS;
				half4 localSampleStochastic3D263_g83296 = SampleStochastic3D( Texture263_g83296 , Sampler263_g83296 , Coords263_g83296 , WorldPosition263_g83296 , WorldNormal263_g83296 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8636_g83242 = localSamplePlanar2D238_g83296;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8636_g83242 = localSamplePlanar3D246_g83296;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8636_g83242 = localSampleStochastic2D234_g83296;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8636_g83242 = localSampleStochastic3D263_g83296;
				#else
				float4 staticSwitch8636_g83242 = localSamplePlanar2D238_g83296;
				#endif
				half4 Layer237_g83247 = staticSwitch8636_g83242;
				TEXTURE2D(Texture238_g83297) = _NormalTex3;
				SamplerState Sampler238_g83297 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83297 = Input_Coords_036789_g83242;
				half4 Coords238_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition238_g83297 = ase_worldPos;
				half4 localSamplePlanar2D238_g83297 = SamplePlanar2D( Texture238_g83297 , Sampler238_g83297 , Coords238_g83297 , WorldPosition238_g83297 );
				TEXTURE2D(Texture246_g83297) = _NormalTex3;
				SamplerState Sampler246_g83297 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition246_g83297 = ase_worldPos;
				half3 WorldNormal246_g83297 = normalWS;
				half4 localSamplePlanar3D246_g83297 = SamplePlanar3D( Texture246_g83297 , Sampler246_g83297 , Coords246_g83297 , WorldPosition246_g83297 , WorldNormal246_g83297 );
				TEXTURE2D(Texture234_g83297) = _NormalTex3;
				SamplerState Sampler234_g83297 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83297 = temp_output_37_0_g83297;
				float3 WorldPosition234_g83297 = ase_worldPos;
				float4 localSampleStochastic2D234_g83297 = SampleStochastic2D( Texture234_g83297 , Sampler234_g83297 , Coords234_g83297 , WorldPosition234_g83297 );
				TEXTURE2D(Texture263_g83297) = _NormalTex3;
				SamplerState Sampler263_g83297 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition263_g83297 = ase_worldPos;
				half3 WorldNormal263_g83297 = normalWS;
				half4 localSampleStochastic3D263_g83297 = SampleStochastic3D( Texture263_g83297 , Sampler263_g83297 , Coords263_g83297 , WorldPosition263_g83297 , WorldNormal263_g83297 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8637_g83242 = localSamplePlanar2D238_g83297;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8637_g83242 = localSamplePlanar3D246_g83297;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8637_g83242 = localSampleStochastic2D234_g83297;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8637_g83242 = localSampleStochastic3D263_g83297;
				#else
				float4 staticSwitch8637_g83242 = localSamplePlanar2D238_g83297;
				#endif
				half4 Layer338_g83247 = staticSwitch8637_g83242;
				TEXTURE2D(Texture238_g83298) = _NormalTex4;
				SamplerState Sampler238_g83298 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83298 = Input_Coords_046791_g83242;
				half4 Coords238_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition238_g83298 = ase_worldPos;
				half4 localSamplePlanar2D238_g83298 = SamplePlanar2D( Texture238_g83298 , Sampler238_g83298 , Coords238_g83298 , WorldPosition238_g83298 );
				TEXTURE2D(Texture246_g83298) = _NormalTex4;
				SamplerState Sampler246_g83298 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition246_g83298 = ase_worldPos;
				half3 WorldNormal246_g83298 = normalWS;
				half4 localSamplePlanar3D246_g83298 = SamplePlanar3D( Texture246_g83298 , Sampler246_g83298 , Coords246_g83298 , WorldPosition246_g83298 , WorldNormal246_g83298 );
				TEXTURE2D(Texture234_g83298) = _NormalTex4;
				SamplerState Sampler234_g83298 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83298 = temp_output_37_0_g83298;
				float3 WorldPosition234_g83298 = ase_worldPos;
				float4 localSampleStochastic2D234_g83298 = SampleStochastic2D( Texture234_g83298 , Sampler234_g83298 , Coords234_g83298 , WorldPosition234_g83298 );
				TEXTURE2D(Texture263_g83298) = _NormalTex4;
				SamplerState Sampler263_g83298 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition263_g83298 = ase_worldPos;
				half3 WorldNormal263_g83298 = normalWS;
				half4 localSampleStochastic3D263_g83298 = SampleStochastic3D( Texture263_g83298 , Sampler263_g83298 , Coords263_g83298 , WorldPosition263_g83298 , WorldNormal263_g83298 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8638_g83242 = localSamplePlanar2D238_g83298;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8638_g83242 = localSamplePlanar3D246_g83298;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8638_g83242 = localSampleStochastic2D234_g83298;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8638_g83242 = localSampleStochastic3D263_g83298;
				#else
				float4 staticSwitch8638_g83242 = localSamplePlanar2D238_g83298;
				#endif
				half4 Layer439_g83247 = staticSwitch8638_g83242;
				float4 weightedBlendVar31_g83247 = Weights52_g83247;
				float4 weightedBlend31_g83247 = ( weightedBlendVar31_g83247.x*Layer133_g83247 + weightedBlendVar31_g83247.y*Layer237_g83247 + weightedBlendVar31_g83247.z*Layer338_g83247 + weightedBlendVar31_g83247.w*Layer439_g83247 );
				half4 Terrain_Normal_047202_g83242 = weightedBlend31_g83247;
				half4 Layer_045_g83257 = Terrain_Normal_047202_g83242;
				half4 Weights52_g83263 = Terrain_Weights_087340_g83242;
				TEXTURE2D(Texture238_g83307) = _NormalTex5;
				SamplerState Sampler238_g83307 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83307 = Input_Coords_058750_g83242;
				half4 Coords238_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition238_g83307 = ase_worldPos;
				half4 localSamplePlanar2D238_g83307 = SamplePlanar2D( Texture238_g83307 , Sampler238_g83307 , Coords238_g83307 , WorldPosition238_g83307 );
				TEXTURE2D(Texture246_g83307) = _NormalTex5;
				SamplerState Sampler246_g83307 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition246_g83307 = ase_worldPos;
				half3 WorldNormal246_g83307 = normalWS;
				half4 localSamplePlanar3D246_g83307 = SamplePlanar3D( Texture246_g83307 , Sampler246_g83307 , Coords246_g83307 , WorldPosition246_g83307 , WorldNormal246_g83307 );
				TEXTURE2D(Texture234_g83307) = _NormalTex5;
				SamplerState Sampler234_g83307 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83307 = temp_output_37_0_g83307;
				float3 WorldPosition234_g83307 = ase_worldPos;
				float4 localSampleStochastic2D234_g83307 = SampleStochastic2D( Texture234_g83307 , Sampler234_g83307 , Coords234_g83307 , WorldPosition234_g83307 );
				TEXTURE2D(Texture263_g83307) = _NormalTex5;
				SamplerState Sampler263_g83307 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition263_g83307 = ase_worldPos;
				half3 WorldNormal263_g83307 = normalWS;
				half4 localSampleStochastic3D263_g83307 = SampleStochastic3D( Texture263_g83307 , Sampler263_g83307 , Coords263_g83307 , WorldPosition263_g83307 , WorldNormal263_g83307 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8686_g83242 = localSamplePlanar2D238_g83307;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8686_g83242 = localSamplePlanar3D246_g83307;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8686_g83242 = localSampleStochastic2D234_g83307;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8686_g83242 = localSampleStochastic3D263_g83307;
				#else
				float4 staticSwitch8686_g83242 = localSamplePlanar2D238_g83307;
				#endif
				half4 Layer133_g83263 = staticSwitch8686_g83242;
				TEXTURE2D(Texture238_g83308) = _NormalTex6;
				SamplerState Sampler238_g83308 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83308 = Input_Coords_068751_g83242;
				half4 Coords238_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition238_g83308 = ase_worldPos;
				half4 localSamplePlanar2D238_g83308 = SamplePlanar2D( Texture238_g83308 , Sampler238_g83308 , Coords238_g83308 , WorldPosition238_g83308 );
				TEXTURE2D(Texture246_g83308) = _NormalTex6;
				SamplerState Sampler246_g83308 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition246_g83308 = ase_worldPos;
				half3 WorldNormal246_g83308 = normalWS;
				half4 localSamplePlanar3D246_g83308 = SamplePlanar3D( Texture246_g83308 , Sampler246_g83308 , Coords246_g83308 , WorldPosition246_g83308 , WorldNormal246_g83308 );
				TEXTURE2D(Texture234_g83308) = _NormalTex6;
				SamplerState Sampler234_g83308 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83308 = temp_output_37_0_g83308;
				float3 WorldPosition234_g83308 = ase_worldPos;
				float4 localSampleStochastic2D234_g83308 = SampleStochastic2D( Texture234_g83308 , Sampler234_g83308 , Coords234_g83308 , WorldPosition234_g83308 );
				TEXTURE2D(Texture263_g83308) = _NormalTex6;
				SamplerState Sampler263_g83308 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition263_g83308 = ase_worldPos;
				half3 WorldNormal263_g83308 = normalWS;
				half4 localSampleStochastic3D263_g83308 = SampleStochastic3D( Texture263_g83308 , Sampler263_g83308 , Coords263_g83308 , WorldPosition263_g83308 , WorldNormal263_g83308 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8687_g83242 = localSamplePlanar2D238_g83308;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8687_g83242 = localSamplePlanar3D246_g83308;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8687_g83242 = localSampleStochastic2D234_g83308;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8687_g83242 = localSampleStochastic3D263_g83308;
				#else
				float4 staticSwitch8687_g83242 = localSamplePlanar2D238_g83308;
				#endif
				half4 Layer237_g83263 = staticSwitch8687_g83242;
				TEXTURE2D(Texture238_g83309) = _NormalTex7;
				SamplerState Sampler238_g83309 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83309 = Input_Coords_078752_g83242;
				half4 Coords238_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition238_g83309 = ase_worldPos;
				half4 localSamplePlanar2D238_g83309 = SamplePlanar2D( Texture238_g83309 , Sampler238_g83309 , Coords238_g83309 , WorldPosition238_g83309 );
				TEXTURE2D(Texture246_g83309) = _NormalTex7;
				SamplerState Sampler246_g83309 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition246_g83309 = ase_worldPos;
				half3 WorldNormal246_g83309 = normalWS;
				half4 localSamplePlanar3D246_g83309 = SamplePlanar3D( Texture246_g83309 , Sampler246_g83309 , Coords246_g83309 , WorldPosition246_g83309 , WorldNormal246_g83309 );
				TEXTURE2D(Texture234_g83309) = _NormalTex7;
				SamplerState Sampler234_g83309 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83309 = temp_output_37_0_g83309;
				float3 WorldPosition234_g83309 = ase_worldPos;
				float4 localSampleStochastic2D234_g83309 = SampleStochastic2D( Texture234_g83309 , Sampler234_g83309 , Coords234_g83309 , WorldPosition234_g83309 );
				TEXTURE2D(Texture263_g83309) = _NormalTex7;
				SamplerState Sampler263_g83309 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition263_g83309 = ase_worldPos;
				half3 WorldNormal263_g83309 = normalWS;
				half4 localSampleStochastic3D263_g83309 = SampleStochastic3D( Texture263_g83309 , Sampler263_g83309 , Coords263_g83309 , WorldPosition263_g83309 , WorldNormal263_g83309 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8688_g83242 = localSamplePlanar2D238_g83309;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8688_g83242 = localSamplePlanar3D246_g83309;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8688_g83242 = localSampleStochastic2D234_g83309;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8688_g83242 = localSampleStochastic3D263_g83309;
				#else
				float4 staticSwitch8688_g83242 = localSamplePlanar2D238_g83309;
				#endif
				half4 Layer338_g83263 = staticSwitch8688_g83242;
				TEXTURE2D(Texture238_g83310) = _NormalTex8;
				SamplerState Sampler238_g83310 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83310 = Input_Coords_088749_g83242;
				half4 Coords238_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition238_g83310 = ase_worldPos;
				half4 localSamplePlanar2D238_g83310 = SamplePlanar2D( Texture238_g83310 , Sampler238_g83310 , Coords238_g83310 , WorldPosition238_g83310 );
				TEXTURE2D(Texture246_g83310) = _NormalTex8;
				SamplerState Sampler246_g83310 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition246_g83310 = ase_worldPos;
				half3 WorldNormal246_g83310 = normalWS;
				half4 localSamplePlanar3D246_g83310 = SamplePlanar3D( Texture246_g83310 , Sampler246_g83310 , Coords246_g83310 , WorldPosition246_g83310 , WorldNormal246_g83310 );
				TEXTURE2D(Texture234_g83310) = _NormalTex8;
				SamplerState Sampler234_g83310 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83310 = temp_output_37_0_g83310;
				float3 WorldPosition234_g83310 = ase_worldPos;
				float4 localSampleStochastic2D234_g83310 = SampleStochastic2D( Texture234_g83310 , Sampler234_g83310 , Coords234_g83310 , WorldPosition234_g83310 );
				TEXTURE2D(Texture263_g83310) = _NormalTex8;
				SamplerState Sampler263_g83310 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition263_g83310 = ase_worldPos;
				half3 WorldNormal263_g83310 = normalWS;
				half4 localSampleStochastic3D263_g83310 = SampleStochastic3D( Texture263_g83310 , Sampler263_g83310 , Coords263_g83310 , WorldPosition263_g83310 , WorldNormal263_g83310 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8689_g83242 = localSamplePlanar2D238_g83310;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8689_g83242 = localSamplePlanar3D246_g83310;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8689_g83242 = localSampleStochastic2D234_g83310;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8689_g83242 = localSampleStochastic3D263_g83310;
				#else
				float4 staticSwitch8689_g83242 = localSamplePlanar2D238_g83310;
				#endif
				half4 Layer439_g83263 = staticSwitch8689_g83242;
				float4 weightedBlendVar31_g83263 = Weights52_g83263;
				float4 weightedBlend31_g83263 = ( weightedBlendVar31_g83263.x*Layer133_g83263 + weightedBlendVar31_g83263.y*Layer237_g83263 + weightedBlendVar31_g83263.z*Layer338_g83263 + weightedBlendVar31_g83263.w*Layer439_g83263 );
				half4 Terrain_Normal_088684_g83242 = weightedBlend31_g83263;
				half4 Layer_0810_g83257 = Terrain_Normal_088684_g83242;
				half4 Weights52_g83273 = Terrain_Weights_127710_g83242;
				TEXTURE2D(Texture238_g83319) = _NormalTex9;
				SamplerState Sampler238_g83319 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83319 = Input_Coords_098833_g83242;
				half4 Coords238_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition238_g83319 = ase_worldPos;
				half4 localSamplePlanar2D238_g83319 = SamplePlanar2D( Texture238_g83319 , Sampler238_g83319 , Coords238_g83319 , WorldPosition238_g83319 );
				TEXTURE2D(Texture246_g83319) = _NormalTex9;
				SamplerState Sampler246_g83319 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition246_g83319 = ase_worldPos;
				half3 WorldNormal246_g83319 = normalWS;
				half4 localSamplePlanar3D246_g83319 = SamplePlanar3D( Texture246_g83319 , Sampler246_g83319 , Coords246_g83319 , WorldPosition246_g83319 , WorldNormal246_g83319 );
				TEXTURE2D(Texture234_g83319) = _NormalTex9;
				SamplerState Sampler234_g83319 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83319 = temp_output_37_0_g83319;
				float3 WorldPosition234_g83319 = ase_worldPos;
				float4 localSampleStochastic2D234_g83319 = SampleStochastic2D( Texture234_g83319 , Sampler234_g83319 , Coords234_g83319 , WorldPosition234_g83319 );
				TEXTURE2D(Texture263_g83319) = _NormalTex9;
				SamplerState Sampler263_g83319 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition263_g83319 = ase_worldPos;
				half3 WorldNormal263_g83319 = normalWS;
				half4 localSampleStochastic3D263_g83319 = SampleStochastic3D( Texture263_g83319 , Sampler263_g83319 , Coords263_g83319 , WorldPosition263_g83319 , WorldNormal263_g83319 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8849_g83242 = localSamplePlanar2D238_g83319;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8849_g83242 = localSamplePlanar3D246_g83319;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8849_g83242 = localSampleStochastic2D234_g83319;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8849_g83242 = localSampleStochastic3D263_g83319;
				#else
				float4 staticSwitch8849_g83242 = localSamplePlanar2D238_g83319;
				#endif
				half4 Layer133_g83273 = staticSwitch8849_g83242;
				TEXTURE2D(Texture238_g83320) = _NormalTex10;
				SamplerState Sampler238_g83320 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83320 = Input_Coords_108834_g83242;
				half4 Coords238_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition238_g83320 = ase_worldPos;
				half4 localSamplePlanar2D238_g83320 = SamplePlanar2D( Texture238_g83320 , Sampler238_g83320 , Coords238_g83320 , WorldPosition238_g83320 );
				TEXTURE2D(Texture246_g83320) = _NormalTex10;
				SamplerState Sampler246_g83320 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition246_g83320 = ase_worldPos;
				half3 WorldNormal246_g83320 = normalWS;
				half4 localSamplePlanar3D246_g83320 = SamplePlanar3D( Texture246_g83320 , Sampler246_g83320 , Coords246_g83320 , WorldPosition246_g83320 , WorldNormal246_g83320 );
				TEXTURE2D(Texture234_g83320) = _NormalTex10;
				SamplerState Sampler234_g83320 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83320 = temp_output_37_0_g83320;
				float3 WorldPosition234_g83320 = ase_worldPos;
				float4 localSampleStochastic2D234_g83320 = SampleStochastic2D( Texture234_g83320 , Sampler234_g83320 , Coords234_g83320 , WorldPosition234_g83320 );
				TEXTURE2D(Texture263_g83320) = _NormalTex10;
				SamplerState Sampler263_g83320 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition263_g83320 = ase_worldPos;
				half3 WorldNormal263_g83320 = normalWS;
				half4 localSampleStochastic3D263_g83320 = SampleStochastic3D( Texture263_g83320 , Sampler263_g83320 , Coords263_g83320 , WorldPosition263_g83320 , WorldNormal263_g83320 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8876_g83242 = localSamplePlanar2D238_g83320;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8876_g83242 = localSamplePlanar3D246_g83320;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8876_g83242 = localSampleStochastic2D234_g83320;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8876_g83242 = localSampleStochastic3D263_g83320;
				#else
				float4 staticSwitch8876_g83242 = localSamplePlanar2D238_g83320;
				#endif
				half4 Layer237_g83273 = staticSwitch8876_g83242;
				TEXTURE2D(Texture238_g83321) = _NormalTex11;
				SamplerState Sampler238_g83321 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83321 = Input_Coords_118835_g83242;
				half4 Coords238_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition238_g83321 = ase_worldPos;
				half4 localSamplePlanar2D238_g83321 = SamplePlanar2D( Texture238_g83321 , Sampler238_g83321 , Coords238_g83321 , WorldPosition238_g83321 );
				TEXTURE2D(Texture246_g83321) = _NormalTex11;
				SamplerState Sampler246_g83321 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition246_g83321 = ase_worldPos;
				half3 WorldNormal246_g83321 = normalWS;
				half4 localSamplePlanar3D246_g83321 = SamplePlanar3D( Texture246_g83321 , Sampler246_g83321 , Coords246_g83321 , WorldPosition246_g83321 , WorldNormal246_g83321 );
				TEXTURE2D(Texture234_g83321) = _NormalTex11;
				SamplerState Sampler234_g83321 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83321 = temp_output_37_0_g83321;
				float3 WorldPosition234_g83321 = ase_worldPos;
				float4 localSampleStochastic2D234_g83321 = SampleStochastic2D( Texture234_g83321 , Sampler234_g83321 , Coords234_g83321 , WorldPosition234_g83321 );
				TEXTURE2D(Texture263_g83321) = _NormalTex11;
				SamplerState Sampler263_g83321 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition263_g83321 = ase_worldPos;
				half3 WorldNormal263_g83321 = normalWS;
				half4 localSampleStochastic3D263_g83321 = SampleStochastic3D( Texture263_g83321 , Sampler263_g83321 , Coords263_g83321 , WorldPosition263_g83321 , WorldNormal263_g83321 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8850_g83242 = localSamplePlanar2D238_g83321;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8850_g83242 = localSamplePlanar3D246_g83321;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8850_g83242 = localSampleStochastic2D234_g83321;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8850_g83242 = localSampleStochastic3D263_g83321;
				#else
				float4 staticSwitch8850_g83242 = localSamplePlanar2D238_g83321;
				#endif
				half4 Layer338_g83273 = staticSwitch8850_g83242;
				TEXTURE2D(Texture238_g83322) = _NormalTex12;
				SamplerState Sampler238_g83322 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83322 = Input_Coords_128836_g83242;
				half4 Coords238_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition238_g83322 = ase_worldPos;
				half4 localSamplePlanar2D238_g83322 = SamplePlanar2D( Texture238_g83322 , Sampler238_g83322 , Coords238_g83322 , WorldPosition238_g83322 );
				TEXTURE2D(Texture246_g83322) = _NormalTex12;
				SamplerState Sampler246_g83322 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition246_g83322 = ase_worldPos;
				half3 WorldNormal246_g83322 = normalWS;
				half4 localSamplePlanar3D246_g83322 = SamplePlanar3D( Texture246_g83322 , Sampler246_g83322 , Coords246_g83322 , WorldPosition246_g83322 , WorldNormal246_g83322 );
				TEXTURE2D(Texture234_g83322) = _NormalTex12;
				SamplerState Sampler234_g83322 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83322 = temp_output_37_0_g83322;
				float3 WorldPosition234_g83322 = ase_worldPos;
				float4 localSampleStochastic2D234_g83322 = SampleStochastic2D( Texture234_g83322 , Sampler234_g83322 , Coords234_g83322 , WorldPosition234_g83322 );
				TEXTURE2D(Texture263_g83322) = _NormalTex12;
				SamplerState Sampler263_g83322 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition263_g83322 = ase_worldPos;
				half3 WorldNormal263_g83322 = normalWS;
				half4 localSampleStochastic3D263_g83322 = SampleStochastic3D( Texture263_g83322 , Sampler263_g83322 , Coords263_g83322 , WorldPosition263_g83322 , WorldNormal263_g83322 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8877_g83242 = localSamplePlanar2D238_g83322;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8877_g83242 = localSamplePlanar3D246_g83322;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8877_g83242 = localSampleStochastic2D234_g83322;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8877_g83242 = localSampleStochastic3D263_g83322;
				#else
				float4 staticSwitch8877_g83242 = localSamplePlanar2D238_g83322;
				#endif
				half4 Layer439_g83273 = staticSwitch8877_g83242;
				float4 weightedBlendVar31_g83273 = Weights52_g83273;
				float4 weightedBlend31_g83273 = ( weightedBlendVar31_g83273.x*Layer133_g83273 + weightedBlendVar31_g83273.y*Layer237_g83273 + weightedBlendVar31_g83273.z*Layer338_g83273 + weightedBlendVar31_g83273.w*Layer439_g83273 );
				half4 Terrain_Normal_128865_g83242 = weightedBlend31_g83273;
				half4 Layer_1243_g83257 = Terrain_Normal_128865_g83242;
				half4 Weights52_g83283 = Terrain_Weights_167709_g83242;
				TEXTURE2D(Texture238_g83338) = _NormalTex13;
				SamplerState Sampler238_g83338 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83338 = Input_Coords_138960_g83242;
				half4 Coords238_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition238_g83338 = ase_worldPos;
				half4 localSamplePlanar2D238_g83338 = SamplePlanar2D( Texture238_g83338 , Sampler238_g83338 , Coords238_g83338 , WorldPosition238_g83338 );
				TEXTURE2D(Texture246_g83338) = _NormalTex13;
				SamplerState Sampler246_g83338 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition246_g83338 = ase_worldPos;
				half3 WorldNormal246_g83338 = normalWS;
				half4 localSamplePlanar3D246_g83338 = SamplePlanar3D( Texture246_g83338 , Sampler246_g83338 , Coords246_g83338 , WorldPosition246_g83338 , WorldNormal246_g83338 );
				TEXTURE2D(Texture234_g83338) = _NormalTex13;
				SamplerState Sampler234_g83338 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83338 = temp_output_37_0_g83338;
				float3 WorldPosition234_g83338 = ase_worldPos;
				float4 localSampleStochastic2D234_g83338 = SampleStochastic2D( Texture234_g83338 , Sampler234_g83338 , Coords234_g83338 , WorldPosition234_g83338 );
				TEXTURE2D(Texture263_g83338) = _NormalTex13;
				SamplerState Sampler263_g83338 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition263_g83338 = ase_worldPos;
				half3 WorldNormal263_g83338 = normalWS;
				half4 localSampleStochastic3D263_g83338 = SampleStochastic3D( Texture263_g83338 , Sampler263_g83338 , Coords263_g83338 , WorldPosition263_g83338 , WorldNormal263_g83338 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch8991_g83242 = localSamplePlanar2D238_g83338;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch8991_g83242 = localSamplePlanar3D246_g83338;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch8991_g83242 = localSampleStochastic2D234_g83338;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch8991_g83242 = localSampleStochastic3D263_g83338;
				#else
				float4 staticSwitch8991_g83242 = localSamplePlanar2D238_g83338;
				#endif
				half4 Layer133_g83283 = staticSwitch8991_g83242;
				TEXTURE2D(Texture238_g83331) = _NormalTex14;
				SamplerState Sampler238_g83331 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83331 = Input_Coords_148961_g83242;
				half4 Coords238_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition238_g83331 = ase_worldPos;
				half4 localSamplePlanar2D238_g83331 = SamplePlanar2D( Texture238_g83331 , Sampler238_g83331 , Coords238_g83331 , WorldPosition238_g83331 );
				TEXTURE2D(Texture246_g83331) = _NormalTex14;
				SamplerState Sampler246_g83331 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition246_g83331 = ase_worldPos;
				half3 WorldNormal246_g83331 = normalWS;
				half4 localSamplePlanar3D246_g83331 = SamplePlanar3D( Texture246_g83331 , Sampler246_g83331 , Coords246_g83331 , WorldPosition246_g83331 , WorldNormal246_g83331 );
				TEXTURE2D(Texture234_g83331) = _NormalTex14;
				SamplerState Sampler234_g83331 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83331 = temp_output_37_0_g83331;
				float3 WorldPosition234_g83331 = ase_worldPos;
				float4 localSampleStochastic2D234_g83331 = SampleStochastic2D( Texture234_g83331 , Sampler234_g83331 , Coords234_g83331 , WorldPosition234_g83331 );
				TEXTURE2D(Texture263_g83331) = _NormalTex14;
				SamplerState Sampler263_g83331 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition263_g83331 = ase_worldPos;
				half3 WorldNormal263_g83331 = normalWS;
				half4 localSampleStochastic3D263_g83331 = SampleStochastic3D( Texture263_g83331 , Sampler263_g83331 , Coords263_g83331 , WorldPosition263_g83331 , WorldNormal263_g83331 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch8990_g83242 = localSamplePlanar2D238_g83331;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch8990_g83242 = localSamplePlanar3D246_g83331;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch8990_g83242 = localSampleStochastic2D234_g83331;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch8990_g83242 = localSampleStochastic3D263_g83331;
				#else
				float4 staticSwitch8990_g83242 = localSamplePlanar2D238_g83331;
				#endif
				half4 Layer237_g83283 = staticSwitch8990_g83242;
				TEXTURE2D(Texture238_g83332) = _NormalTex15;
				SamplerState Sampler238_g83332 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83332 = Input_Coords_158962_g83242;
				half4 Coords238_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition238_g83332 = ase_worldPos;
				half4 localSamplePlanar2D238_g83332 = SamplePlanar2D( Texture238_g83332 , Sampler238_g83332 , Coords238_g83332 , WorldPosition238_g83332 );
				TEXTURE2D(Texture246_g83332) = _NormalTex15;
				SamplerState Sampler246_g83332 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition246_g83332 = ase_worldPos;
				half3 WorldNormal246_g83332 = normalWS;
				half4 localSamplePlanar3D246_g83332 = SamplePlanar3D( Texture246_g83332 , Sampler246_g83332 , Coords246_g83332 , WorldPosition246_g83332 , WorldNormal246_g83332 );
				TEXTURE2D(Texture234_g83332) = _NormalTex15;
				SamplerState Sampler234_g83332 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83332 = temp_output_37_0_g83332;
				float3 WorldPosition234_g83332 = ase_worldPos;
				float4 localSampleStochastic2D234_g83332 = SampleStochastic2D( Texture234_g83332 , Sampler234_g83332 , Coords234_g83332 , WorldPosition234_g83332 );
				TEXTURE2D(Texture263_g83332) = _NormalTex15;
				SamplerState Sampler263_g83332 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition263_g83332 = ase_worldPos;
				half3 WorldNormal263_g83332 = normalWS;
				half4 localSampleStochastic3D263_g83332 = SampleStochastic3D( Texture263_g83332 , Sampler263_g83332 , Coords263_g83332 , WorldPosition263_g83332 , WorldNormal263_g83332 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch8989_g83242 = localSamplePlanar2D238_g83332;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch8989_g83242 = localSamplePlanar3D246_g83332;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch8989_g83242 = localSampleStochastic2D234_g83332;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch8989_g83242 = localSampleStochastic3D263_g83332;
				#else
				float4 staticSwitch8989_g83242 = localSamplePlanar2D238_g83332;
				#endif
				half4 Layer338_g83283 = staticSwitch8989_g83242;
				TEXTURE2D(Texture238_g83333) = _NormalTex16;
				SamplerState Sampler238_g83333 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83333 = Input_Coords_168959_g83242;
				half4 Coords238_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition238_g83333 = ase_worldPos;
				half4 localSamplePlanar2D238_g83333 = SamplePlanar2D( Texture238_g83333 , Sampler238_g83333 , Coords238_g83333 , WorldPosition238_g83333 );
				TEXTURE2D(Texture246_g83333) = _NormalTex16;
				SamplerState Sampler246_g83333 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition246_g83333 = ase_worldPos;
				half3 WorldNormal246_g83333 = normalWS;
				half4 localSamplePlanar3D246_g83333 = SamplePlanar3D( Texture246_g83333 , Sampler246_g83333 , Coords246_g83333 , WorldPosition246_g83333 , WorldNormal246_g83333 );
				TEXTURE2D(Texture234_g83333) = _NormalTex16;
				SamplerState Sampler234_g83333 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83333 = temp_output_37_0_g83333;
				float3 WorldPosition234_g83333 = ase_worldPos;
				float4 localSampleStochastic2D234_g83333 = SampleStochastic2D( Texture234_g83333 , Sampler234_g83333 , Coords234_g83333 , WorldPosition234_g83333 );
				TEXTURE2D(Texture263_g83333) = _NormalTex16;
				SamplerState Sampler263_g83333 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition263_g83333 = ase_worldPos;
				half3 WorldNormal263_g83333 = normalWS;
				half4 localSampleStochastic3D263_g83333 = SampleStochastic3D( Texture263_g83333 , Sampler263_g83333 , Coords263_g83333 , WorldPosition263_g83333 , WorldNormal263_g83333 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch8988_g83242 = localSamplePlanar2D238_g83333;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch8988_g83242 = localSamplePlanar3D246_g83333;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch8988_g83242 = localSampleStochastic2D234_g83333;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch8988_g83242 = localSampleStochastic3D263_g83333;
				#else
				float4 staticSwitch8988_g83242 = localSamplePlanar2D238_g83333;
				#endif
				half4 Layer439_g83283 = staticSwitch8988_g83242;
				float4 weightedBlendVar31_g83283 = Weights52_g83283;
				float4 weightedBlend31_g83283 = ( weightedBlendVar31_g83283.x*Layer133_g83283 + weightedBlendVar31_g83283.y*Layer237_g83283 + weightedBlendVar31_g83283.z*Layer338_g83283 + weightedBlendVar31_g83283.w*Layer439_g83283 );
				half4 Terrain_Normal_168987_g83242 = weightedBlend31_g83283;
				half4 Layer_1644_g83257 = Terrain_Normal_168987_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83257 = Layer_045_g83257;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 + Layer_1243_g83257 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 + Layer_1243_g83257 + Layer_1644_g83257 );
				#else
				float4 staticSwitch40_g83257 = Layer_045_g83257;
				#endif
				half4 Blend_Normal7512_g83242 = staticSwitch40_g83257;
				half4 Normal_Packed45_g83244 = Blend_Normal7512_g83242;
				float2 appendResult58_g83244 = (float2(( (Normal_Packed45_g83244).x * (Normal_Packed45_g83244).w ) , (Normal_Packed45_g83244).y));
				half2 Normal_Default50_g83244 = appendResult58_g83244;
				half2 Normal_ASTC41_g83244 = (Normal_Packed45_g83244).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g83244 = Normal_ASTC41_g83244;
				#else
				float2 staticSwitch38_g83244 = Normal_Default50_g83244;
				#endif
				half2 Normal_NO_DTX544_g83244 = (Normal_Packed45_g83244).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g83244 = Normal_NO_DTX544_g83244;
				#else
				float2 staticSwitch37_g83244 = staticSwitch38_g83244;
				#endif
				half4 Weights52_g83249 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83249 = temp_output_6970_0_g83242;
				half4 Layer237_g83249 = temp_output_6977_0_g83242;
				half4 Layer338_g83249 = temp_output_6978_0_g83242;
				half4 Layer439_g83249 = temp_output_6983_0_g83242;
				float4 weightedBlendVar31_g83249 = Weights52_g83249;
				float4 weightedBlend31_g83249 = ( weightedBlendVar31_g83249.x*Layer133_g83249 + weightedBlendVar31_g83249.y*Layer237_g83249 + weightedBlendVar31_g83249.z*Layer338_g83249 + weightedBlendVar31_g83249.w*Layer439_g83249 );
				half4 Terrain_Masks_047203_g83242 = weightedBlend31_g83249;
				half4 Layer_045_g83259 = Terrain_Masks_047203_g83242;
				half4 Weights52_g83266 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83266 = temp_output_8714_0_g83242;
				half4 Layer237_g83266 = temp_output_8721_0_g83242;
				half4 Layer338_g83266 = temp_output_8724_0_g83242;
				half4 Layer439_g83266 = temp_output_8727_0_g83242;
				float4 weightedBlendVar31_g83266 = Weights52_g83266;
				float4 weightedBlend31_g83266 = ( weightedBlendVar31_g83266.x*Layer133_g83266 + weightedBlendVar31_g83266.y*Layer237_g83266 + weightedBlendVar31_g83266.z*Layer338_g83266 + weightedBlendVar31_g83266.w*Layer439_g83266 );
				half4 Terrain_Masks_088730_g83242 = weightedBlend31_g83266;
				half4 Layer_0810_g83259 = Terrain_Masks_088730_g83242;
				half4 Weights52_g83276 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83276 = temp_output_8815_0_g83242;
				half4 Layer237_g83276 = temp_output_8818_0_g83242;
				half4 Layer338_g83276 = temp_output_8819_0_g83242;
				half4 Layer439_g83276 = temp_output_8820_0_g83242;
				float4 weightedBlendVar31_g83276 = Weights52_g83276;
				float4 weightedBlend31_g83276 = ( weightedBlendVar31_g83276.x*Layer133_g83276 + weightedBlendVar31_g83276.y*Layer237_g83276 + weightedBlendVar31_g83276.z*Layer338_g83276 + weightedBlendVar31_g83276.w*Layer439_g83276 );
				half4 Terrain_Masks_128871_g83242 = weightedBlend31_g83276;
				half4 Layer_1243_g83259 = Terrain_Masks_128871_g83242;
				half4 Weights52_g83286 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83286 = temp_output_8931_0_g83242;
				half4 Layer237_g83286 = temp_output_8934_0_g83242;
				half4 Layer338_g83286 = temp_output_8935_0_g83242;
				half4 Layer439_g83286 = temp_output_8936_0_g83242;
				float4 weightedBlendVar31_g83286 = Weights52_g83286;
				float4 weightedBlend31_g83286 = ( weightedBlendVar31_g83286.x*Layer133_g83286 + weightedBlendVar31_g83286.y*Layer237_g83286 + weightedBlendVar31_g83286.z*Layer338_g83286 + weightedBlendVar31_g83286.w*Layer439_g83286 );
				half4 Terrain_Masks_169014_g83242 = weightedBlend31_g83286;
				half4 Layer_1644_g83259 = Terrain_Masks_169014_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83259 = Layer_045_g83259;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 + Layer_1243_g83259 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 + Layer_1243_g83259 + Layer_1644_g83259 );
				#else
				float4 staticSwitch40_g83259 = Layer_045_g83259;
				#endif
				half4 Blend_Masks7420_g83242 = staticSwitch40_g83259;
				half4 Normal_Packed45_g83243 = Blend_Masks7420_g83242;
				half2 Normal_NO_DTX544_g83243 = (Normal_Packed45_g83243).wy;
				#ifdef TVE_PACKED_TEX
				float2 staticSwitch8562_g83242 = (Normal_NO_DTX544_g83243*2.0 + -1.0);
				#else
				float2 staticSwitch8562_g83242 = (staticSwitch37_g83244*2.0 + -1.0);
				#endif
				half4 Weights52_g83253 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83253 = _Params1;
				half4 Layer237_g83253 = _Params2;
				half4 Layer338_g83253 = _Params3;
				half4 Layer439_g83253 = _Params4;
				float4 weightedBlendVar31_g83253 = Weights52_g83253;
				float4 weightedBlend31_g83253 = ( weightedBlendVar31_g83253.x*Layer133_g83253 + weightedBlendVar31_g83253.y*Layer237_g83253 + weightedBlendVar31_g83253.z*Layer338_g83253 + weightedBlendVar31_g83253.w*Layer439_g83253 );
				half4 Terrain_Params_047533_g83242 = weightedBlend31_g83253;
				half4 Layer_045_g83260 = Terrain_Params_047533_g83242;
				half4 Weights52_g83270 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83270 = _Params5;
				half4 Layer237_g83270 = _Params6;
				half4 Layer338_g83270 = _Params7;
				half4 Layer439_g83270 = _Params8;
				float4 weightedBlendVar31_g83270 = Weights52_g83270;
				float4 weightedBlend31_g83270 = ( weightedBlendVar31_g83270.x*Layer133_g83270 + weightedBlendVar31_g83270.y*Layer237_g83270 + weightedBlendVar31_g83270.z*Layer338_g83270 + weightedBlendVar31_g83270.w*Layer439_g83270 );
				half4 Terrain_Params_088739_g83242 = weightedBlend31_g83270;
				half4 Layer_0810_g83260 = Terrain_Params_088739_g83242;
				half4 Weights52_g83280 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83280 = _Params9;
				half4 Layer237_g83280 = _Params10;
				half4 Layer338_g83280 = _Params11;
				half4 Layer439_g83280 = _Params12;
				float4 weightedBlendVar31_g83280 = Weights52_g83280;
				float4 weightedBlend31_g83280 = ( weightedBlendVar31_g83280.x*Layer133_g83280 + weightedBlendVar31_g83280.y*Layer237_g83280 + weightedBlendVar31_g83280.z*Layer338_g83280 + weightedBlendVar31_g83280.w*Layer439_g83280 );
				half4 Terrain_Params_128867_g83242 = weightedBlend31_g83280;
				half4 Layer_1243_g83260 = Terrain_Params_128867_g83242;
				half4 Weights52_g83290 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83290 = _Params13;
				half4 Layer237_g83290 = _Params14;
				half4 Layer338_g83290 = _Params15;
				half4 Layer439_g83290 = _Params16;
				float4 weightedBlendVar31_g83290 = Weights52_g83290;
				float4 weightedBlend31_g83290 = ( weightedBlendVar31_g83290.x*Layer133_g83290 + weightedBlendVar31_g83290.y*Layer237_g83290 + weightedBlendVar31_g83290.z*Layer338_g83290 + weightedBlendVar31_g83290.w*Layer439_g83290 );
				half4 Terrain_Params_169017_g83242 = weightedBlend31_g83290;
				half4 Layer_1644_g83260 = Terrain_Params_169017_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83260 = Layer_045_g83260;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 + Layer_1243_g83260 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 + Layer_1243_g83260 + Layer_1644_g83260 );
				#else
				float4 staticSwitch40_g83260 = Layer_045_g83260;
				#endif
				half4 Blend_Params7547_g83242 = staticSwitch40_g83260;
				half2 Normal_Planar45_g83246 = ( staticSwitch8562_g83242 * (Blend_Params7547_g83242).z );
				float2 break64_g83246 = Normal_Planar45_g83246;
				float3 appendResult65_g83246 = (float3(break64_g83246.x , 0.0 , break64_g83246.y));
				half2 Terrain_Normal6871_g79798 = (mul( ase_worldToTangent, appendResult65_g83246 )).xy;
				float2 temp_output_7045_0_g79798 = ( Terrain_Normal6871_g79798 * _TerrainNormalValue );
				float3 appendResult7219_g79798 = (float3(temp_output_7045_0_g79798 , 1.0));
				float3 tanToWorld0 = float3( tangentWS.xyz.x, ase_worldBitangent.x, normalWS.x );
				float3 tanToWorld1 = float3( tangentWS.xyz.y, ase_worldBitangent.y, normalWS.y );
				float3 tanToWorld2 = float3( tangentWS.xyz.z, ase_worldBitangent.z, normalWS.z );
				float3 tanNormal7220_g79798 = appendResult7219_g79798;
				float3 worldNormal7220_g79798 = normalize( float3(dot(tanToWorld0,tanNormal7220_g79798), dot(tanToWorld1,tanNormal7220_g79798), dot(tanToWorld2,tanNormal7220_g79798)) );
				half3 Blend_Normal_WS7221_g79798 = worldNormal7220_g79798;
				float temp_output_7222_0_g79798 = (Blend_Normal_WS7221_g79798).y;
				float lerpResult6757_g79798 = lerp( 1.0 , saturate( temp_output_7222_0_g79798 ) , _OverlayProjectionValue);
				half Overlay_Projection6081_g79798 = lerpResult6757_g79798;
				half Overlay_Shading6688_g79798 = Blend_Albedo_Globals6410_g79798;
				half Overlay_Custom6707_g79798 = 1.0;
				float temp_output_7_0_g79848 = 0.1;
				float temp_output_10_0_g79848 = ( 0.2 - temp_output_7_0_g79848 );
				half Overlay_Mask_High6064_g79798 = saturate( ( ( ( Overlay_Value5738_g79798 * Overlay_Projection6081_g79798 * Overlay_Shading6688_g79798 * Overlay_Custom6707_g79798 ) - temp_output_7_0_g79848 ) / ( temp_output_10_0_g79848 + 0.0001 ) ) );
				half Overlay_Mask269_g79798 = Overlay_Mask_High6064_g79798;
				float3 lerpResult336_g79798 = lerp( Blend_Albedo_Colored863_g79798 , Global_OverlayColor1758_g79798 , Overlay_Mask269_g79798);
				half3 Blend_Albedo_Overlay359_g79798 = lerpResult336_g79798;
				half Global_WetnessContrast6502_g79798 = TVE_WetnessContrast;
				half Global_Extras_Wetness305_g79798 = break456_g79805.y;
				half Wetness_Value6343_g79798 = ( Global_Extras_Wetness305_g79798 * _GlobalWetness );
				float3 lerpResult6367_g79798 = lerp( Blend_Albedo_Overlay359_g79798 , ( Blend_Albedo_Overlay359_g79798 * Blend_Albedo_Overlay359_g79798 ) , ( Global_WetnessContrast6502_g79798 * Wetness_Value6343_g79798 ));
				half3 Blend_Albedo_Wetness6351_g79798 = lerpResult6367_g79798;
				
				half2 Blend_Normal312_g79798 = temp_output_7045_0_g79798;
				half Global_OverlayNormalScale6581_g79798 = TVE_OverlayNormalValue;
				float lerpResult6585_g79798 = lerp( 1.0 , Global_OverlayNormalScale6581_g79798 , Overlay_Mask269_g79798);
				half2 Blend_Normal_Overlay366_g79798 = ( Blend_Normal312_g79798 * lerpResult6585_g79798 );
				half Global_WetnessNormalScale6571_g79798 = TVE_WetnessNormalValue;
				float lerpResult6579_g79798 = lerp( 1.0 , Global_WetnessNormalScale6571_g79798 , ( Wetness_Value6343_g79798 * Wetness_Value6343_g79798 ));
				half2 Blend_Normal_Wetness6372_g79798 = ( Blend_Normal_Overlay366_g79798 * lerpResult6579_g79798 );
				float3 appendResult6568_g79798 = (float3(Blend_Normal_Wetness6372_g79798 , 1.0));
				
				float3 temp_cast_17 = (0.0).xxx;
				float3 lerpResult7362_g79798 = lerp( float3( 1,1,1 ) , (Terrain_Albedo6800_g79798).xyz , _EmissiveAlbedoMode);
				half3 Emissive_Color7279_g79798 = ( (_EmissiveColor).rgb * (Terrain_Specular7322_g79798).rgb * lerpResult7362_g79798 );
				half Emissive_Texture7282_g79798 = (Terrain_Albedo6800_g79798).w;
				half Global_Extras_Emissive4203_g79798 = break456_g79805.x;
				float lerpResult7266_g79798 = lerp( 1.0 , Global_Extras_Emissive4203_g79798 , _GlobalEmissive);
				half Emissive_Value7264_g79798 = ( lerpResult7266_g79798 * _EmissivePhaseValue );
				half Emissive_Mask7291_g79798 = saturate( ( Emissive_Texture7282_g79798 + ( Emissive_Value7264_g79798 - 1.0 ) ) );
				float3 temp_output_3_0_g79858 = ( Emissive_Color7279_g79798 * Emissive_Mask7291_g79798 );
				float temp_output_15_0_g79858 = _emissive_intensity_value;
				float3 hdEmission22_g79858 = ASEGetEmissionHDRColor(temp_output_3_0_g79858,temp_output_15_0_g79858,_EmissiveExposureValue,GetInverseCurrentExposureMultiplier());
				#ifdef TVE_EMISSIVE
				float3 staticSwitch7437_g79798 = hdEmission22_g79858;
				#else
				float3 staticSwitch7437_g79798 = temp_cast_17;
				#endif
				half3 Blend_Emissive7261_g79798 = staticSwitch7437_g79798;
				
				#ifdef TVE_PACKED_TEX
				float staticSwitch8571_g83242 = 0.0;
				#else
				float staticSwitch8571_g83242 = ( (Blend_Masks7420_g83242).x * (Blend_Params7547_g83242).x );
				#endif
				#ifdef TVE_PACKED_TEX
				float staticSwitch8559_g83242 = 1.0;
				#else
				float staticSwitch8559_g83242 = (Blend_Masks7420_g83242).y;
				#endif
				#ifdef TVE_PACKED_TEX
				float staticSwitch8560_g83242 = (Blend_Masks7420_g83242).x;
				#else
				float staticSwitch8560_g83242 = (Blend_Masks7420_g83242).w;
				#endif
				float4 appendResult8574_g83242 = (float4(staticSwitch8571_g83242 , staticSwitch8559_g83242 , (Blend_Masks7420_g83242).z , ( staticSwitch8560_g83242 * (Blend_Params7547_g83242).w )));
				half4 Terrain_Masks7251_g79798 = appendResult8574_g83242;
				half Blend_Smoothness314_g79798 = ( (Terrain_Masks7251_g79798).w * _TerrainSmoothnessValue );
				half Global_OverlaySmoothness311_g79798 = TVE_OverlaySmoothness;
				float lerpResult343_g79798 = lerp( Blend_Smoothness314_g79798 , Global_OverlaySmoothness311_g79798 , Overlay_Mask269_g79798);
				half Blend_Smoothness_Overlay371_g79798 = lerpResult343_g79798;
				float temp_output_6499_0_g79798 = ( 1.0 - Wetness_Value6343_g79798 );
				half Blend_Smoothness_Wetness4130_g79798 = saturate( ( Blend_Smoothness_Overlay371_g79798 + ( 1.0 - ( temp_output_6499_0_g79798 * temp_output_6499_0_g79798 ) ) ) );
				
				float lerpResult7046_g79798 = lerp( 1.0 , (Terrain_Masks7251_g79798).y , _TerrainOcclusionValue);
				half Blend_Occlusion7306_g79798 = lerpResult7046_g79798;
				
				float localCustomAlphaClip19_g83341 = ( 0.0 );
				half Terrain_Holes7437_g83242 = SAMPLE_TEXTURE2D( _HolesTex, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 ).r;
				half Terrain_Holes7159_g79798 = Terrain_Holes7437_g83242;
				half Global_Extras_Alpha1033_g79798 = saturate( break456_g79805.w );
				float lerpResult7479_g79798 = lerp( 1.0 , Global_Extras_Alpha1033_g79798 , _GlobalAlpha);
				half Alpha_Global7481_g79798 = lerpResult7479_g79798;
				half AlphaTreshold2132_g79798 = _AlphaClipValue;
				float temp_output_3_0_g83341 = ( ( Terrain_Holes7159_g79798 * Alpha_Global7481_g79798 ) - AlphaTreshold2132_g79798 );
				float Alpha19_g83341 = temp_output_3_0_g83341;
				float temp_output_15_0_g83341 = 0.01;
				float Treshold19_g83341 = temp_output_15_0_g83341;
				{
				#if defined (TVE_ALPHA_CLIP) || defined (TVE_ALPHA_FADE) || defined (TVE_ALPHA_GLOBAL)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#else
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#endif
				}
				
				surfaceDescription.BaseColor = Blend_Albedo_Wetness6351_g79798;
				surfaceDescription.Normal = appendResult6568_g79798;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = Blend_Emissive7261_g79798;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g79798;
				surfaceDescription.Occlusion = Blend_Occlusion7306_g79798;
				surfaceDescription.Alpha = Alpha19_g83341;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				surfaceDescription.AlphaClipThresholdDepthPrepass = 0.5;
				surfaceDescription.AlphaClipThresholdDepthPostpass = 0.5;

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 0;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif
				#ifdef ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				#endif

				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );
				ENCODE_INTO_GBUFFER( surfaceData, builtinData, posInput.positionSS, outGBuffer );
				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140011
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma shader_feature _ EDITOR_VISUALIZATION
			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

            #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT
            #define SCENEPICKINGPASS 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

            #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
            #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MaskMax8;
			half4 _Coords7;
			half4 _MaskMax6;
			half4 _MaskMin6;
			half4 _Coords6;
			half4 _MaskMax5;
			half4 _MaskMin5;
			half4 _Coords5;
			half4 _MaskMax4;
			half4 _MaskMin4;
			half4 _MaskMin7;
			half4 _Coords4;
			half4 _MaskMin3;
			half4 _Coords3;
			half4 _MaskMax2;
			half4 _MaskMin2;
			half4 _Coords2;
			half4 _MaskMax1;
			half4 _MaskMin1;
			half4 _Coords1;
			half4 _MaskMax16;
			half4 _MaskMax3;
			half4 _MaskMax7;
			half4 _Coords8;
			half4 _MaskMin8;
			half4 _MaskMin15;
			half4 _Coords15;
			half4 _MaskMax14;
			half4 _MaskMin14;
			half4 _Coords14;
			half4 _MaskMax13;
			half4 _MaskMin13;
			half4 _Coords13;
			half4 _MaskMax12;
			half4 _MaskMin12;
			half4 _Coords12;
			half4 _MaskMax11;
			half4 _MaskMin11;
			half4 _Coords11;
			half4 _MaskMax10;
			half4 _MaskMin10;
			half4 _Coords10;
			half4 _MaskMax9;
			half4 _MaskMin9;
			half4 _Coords9;
			half4 _MaskMin16;
			half4 _TerrainColor;
			half4 _MaskMax15;
			half4 _Coords16;
			half4 _Params5;
			half4 _Params2;
			half4 _Params3;
			half4 _Params4;
			half4 _Params6;
			half4 _Params7;
			half4 _Params8;
			half4 _Params1;
			half4 _Params9;
			half4 _Params11;
			half4 _Params12;
			half4 _Params13;
			half4 _Params14;
			half4 _Params15;
			half4 _Params16;
			half4 _Params10;
			half4 _Specular16;
			half4 _EmissiveColor;
			half4 _Specular7;
			half4 _Specular3;
			half4 _Specular4;
			half4 _Specular5;
			half4 _Specular6;
			half4 _Specular15;
			half4 _Specular8;
			half4 _Specular2;
			half4 _Specular9;
			half4 _Specular11;
			half4 _Specular12;
			half4 _Specular13;
			half4 _Specular14;
			half4 _Specular10;
			half4 _Specular1;
			half _EmissivePhaseValue;
			half _GlobalEmissive;
			half _TerrainSmoothnessValue;
			float _emissive_intensity_value;
			half _EmissiveAlbedoMode;
			half _TerrainOcclusionValue;
			half _EmissiveExposureValue;
			half _GlobalColors;
			half _OverlayProjectionValue;
			half _TerrainNormalValue;
			half _ColorsIntensityValue;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _TerrainHeightBlendValue;
			half _GlobalWetness;
			half _LayerColorsValue;
			half _CategoryGlobals;
			half _GlobalHeight;
			half _CategoryEmissive;
			half _CategoryMotion;
			half _EmissiveIntensityValue;
			half _EmissiveIntensityMode;
			half _EmissiveFlagMode;
			half _IsVersion;
			half _IsTerrainShader;
			half _CategoryRender;
			half _MessageTerrainEmissive;
			half _MessageTerrainColors;
			half _CategoryTerrain;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _IsCustomShader;
			half _IsShared;
			half _IsCollected;
			half _IsIdentifier;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceGlobalOptions;
			half _SpaceGlobalLocals;
			half _SpaceGlobalLayers;
			half _CategoryLayers;
			half _GlobalAlpha;
			half _TerrainLayersMode;
			half _TerrainBlendMode;
			half _LayerVertexValue;
			half _RenderClip;
			half _LayerSampleMode16;
			half _LayerSampleMode15;
			half _LayerSampleMode14;
			half _LayerSampleMode13;
			half _LayerSampleMode12;
			half _LayerSampleMode11;
			half _LayerSampleMode10;
			half _LayerSampleMode9;
			half _LayerSampleMode8;
			half _LayerSampleMode7;
			half _LayerSampleMode6;
			half _LayerSampleMode5;
			half _LayerSampleMode1;
			half _LayerSampleMode4;
			half _LayerSampleMode3;
			half _LayerSampleMode2;
			half _CategoryInputs;
			half _TerrainTexMode;
			half _RenderMode;
			half _RenderDecals;
			half _EmissiveMode;
			half _MessageTerrainMasks;
			half _AlphaClipValue;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(sampler_Linear_Clamp);
			half4 TVE_VertexParams;
			TEXTURE2D(_ControlTex1);
			SAMPLER(sampler_Linear_Clamp_Aniso8);
			TEXTURE2D(_ControlTex2);
			TEXTURE2D(_ControlTex3);
			TEXTURE2D(_ControlTex4);
			TEXTURE2D(_MaskTex1);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			TEXTURE2D(_MaskTex2);
			TEXTURE2D(_MaskTex3);
			TEXTURE2D(_MaskTex4);
			TEXTURE2D(_MaskTex5);
			TEXTURE2D(_MaskTex6);
			TEXTURE2D(_MaskTex7);
			TEXTURE2D(_MaskTex8);
			TEXTURE2D(_MaskTex9);
			TEXTURE2D(_MaskTex10);
			TEXTURE2D(_MaskTex11);
			TEXTURE2D(_MaskTex12);
			TEXTURE2D(_MaskTex13);
			TEXTURE2D(_MaskTex14);
			TEXTURE2D(_MaskTex15);
			TEXTURE2D(_MaskTex16);
			TEXTURE2D(_AlbedoTex1);
			TEXTURE2D(_AlbedoTex2);
			TEXTURE2D(_AlbedoTex3);
			TEXTURE2D(_AlbedoTex4);
			TEXTURE2D(_AlbedoTex5);
			TEXTURE2D(_AlbedoTex6);
			TEXTURE2D(_AlbedoTex7);
			TEXTURE2D(_AlbedoTex8);
			TEXTURE2D(_AlbedoTex9);
			TEXTURE2D(_AlbedoTex10);
			TEXTURE2D(_AlbedoTex11);
			TEXTURE2D(_AlbedoTex12);
			TEXTURE2D(_AlbedoTex13);
			TEXTURE2D(_AlbedoTex14);
			TEXTURE2D(_AlbedoTex15);
			TEXTURE2D(_AlbedoTex16);
			float TVE_ColorsUsage[10];
			TEXTURE2D_ARRAY(TVE_ColorsTex);
			half4 TVE_ColorsCoords;
			half4 TVE_ColorsParams;
			half TVE_IsEnabled;
			half4 TVE_OverlayColor;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			TEXTURE2D(_NormalTex1);
			TEXTURE2D(_NormalTex2);
			TEXTURE2D(_NormalTex3);
			TEXTURE2D(_NormalTex4);
			TEXTURE2D(_NormalTex5);
			TEXTURE2D(_NormalTex6);
			TEXTURE2D(_NormalTex7);
			TEXTURE2D(_NormalTex8);
			TEXTURE2D(_NormalTex9);
			TEXTURE2D(_NormalTex10);
			TEXTURE2D(_NormalTex11);
			TEXTURE2D(_NormalTex12);
			TEXTURE2D(_NormalTex13);
			TEXTURE2D(_NormalTex14);
			TEXTURE2D(_NormalTex15);
			TEXTURE2D(_NormalTex16);
			half TVE_WetnessContrast;
			half TVE_OverlayNormalValue;
			half TVE_WetnessNormalValue;
			half TVE_OverlaySmoothness;
			TEXTURE2D(_HolesTex);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#if SHADERPASS == SHADERPASS_LIGHT_TRANSPORT
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/MetaPass.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#pragma shader_feature_local_fragment TVE_ALPHA_CLIP
			#pragma shader_feature_local_fragment TVE_TERRAIN_04 TVE_TERRAIN_08 TVE_TERRAIN_12 TVE_TERRAIN_16
			#pragma shader_feature_local_fragment TVE_HEIGHT_BLEND
			#pragma shader_feature_local_fragment TVE_SAMPLE_01_PLANAR_2D TVE_SAMPLE_01_PLANAR_3D TVE_SAMPLE_01_STOCHASTIC_2D TVE_SAMPLE_01_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_02_PLANAR_2D TVE_SAMPLE_02_PLANAR_3D TVE_SAMPLE_02_STOCHASTIC_2D TVE_SAMPLE_02_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_03_PLANAR_2D TVE_SAMPLE_03_PLANAR_3D TVE_SAMPLE_03_STOCHASTIC_2D TVE_SAMPLE_03_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_04_PLANAR_2D TVE_SAMPLE_04_PLANAR_3D TVE_SAMPLE_04_STOCHASTIC_2D TVE_SAMPLE_04_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_05_PLANAR_2D TVE_SAMPLE_05_PLANAR_3D TVE_SAMPLE_05_STOCHASTIC_2D TVE_SAMPLE_05_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_06_PLANAR_2D TVE_SAMPLE_06_PLANAR_3D TVE_SAMPLE_06_STOCHASTIC_2D TVE_SAMPLE_06_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_07_PLANAR_2D TVE_SAMPLE_07_PLANAR_3D TVE_SAMPLE_07_STOCHASTIC_2D TVE_SAMPLE_07_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_08_PLANAR_2D TVE_SAMPLE_08_PLANAR_3D TVE_SAMPLE_08_STOCHASTIC_2D TVE_SAMPLE_08_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_09_PLANAR_2D TVE_SAMPLE_09_PLANAR_3D TVE_SAMPLE_09_STOCHASTIC_2D TVE_SAMPLE_09_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_10_PLANAR_2D TVE_SAMPLE_10_PLANAR_3D TVE_SAMPLE_10_STOCHASTIC_2D TVE_SAMPLE_10_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_11_PLANAR_2D TVE_SAMPLE_11_PLANAR_3D TVE_SAMPLE_11_STOCHASTIC_2D TVE_SAMPLE_11_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_12_PLANAR_2D TVE_SAMPLE_12_PLANAR_3D TVE_SAMPLE_12_STOCHASTIC_2D TVE_SAMPLE_12_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_13_PLANAR_2D TVE_SAMPLE_13_PLANAR_3D TVE_SAMPLE_13_STOCHASTIC_2D TVE_SAMPLE_13_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_14_PLANAR_2D TVE_SAMPLE_14_PLANAR_3D TVE_SAMPLE_14_STOCHASTIC_2D TVE_SAMPLE_14_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_15_PLANAR_2D TVE_SAMPLE_15_PLANAR_3D TVE_SAMPLE_15_STOCHASTIC_2D TVE_SAMPLE_15_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_16_PLANAR_2D TVE_SAMPLE_16_PLANAR_3D TVE_SAMPLE_16_STOCHASTIC_2D TVE_SAMPLE_16_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_PACKED_TEX
			#pragma shader_feature_local_fragment TVE_EMISSIVE
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap forwardadd
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				#ifdef EDITOR_VISUALIZATION
				float2 VizUV : TEXCOORD0;
				float4 LightCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			void ComputeWorldCoords( half4 Coords, half3 WorldPosition, out half2 ZX, out half2 ZY, out half2 XY )
			{
				ZX = WorldPosition.xz * Coords.xy + Coords.zw;
				ZY = WorldPosition.zy * Coords.xy + Coords.zw; 
				XY = WorldPosition.xy * Coords.xy + Coords.zw;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half4 tex = SAMPLE_TEXTURE2D( Texture, Sampler, ZX);
				return tex;
			}
			
			void ComputeTriplanarWeights( half3 WorldNormal, out half T1, out half T2, out half T3 )
			{
				half3 powNormal = abs( WorldNormal.xyz );
				half3 weights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.000001 );
				weights /= ( weights.x + weights.y + weights.z ).xxx;
				T1 = weights.y;
				T2 = weights.x;
				T3 = weights.z;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition, half3 WorldNormal )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half T1, T2, T3;
				ComputeTriplanarWeights(WorldNormal, T1, T2, T3);
				half4 tex1 = SAMPLE_TEXTURE2D( Texture, Sampler, ZX);
				half4 tex2 = SAMPLE_TEXTURE2D( Texture, Sampler, ZY);
				half4 tex3 = SAMPLE_TEXTURE2D( Texture, Sampler, XY);
				return tex1 * T1 + tex2 * T2 + tex3 * T3;
			}
			
			void ComputeStochasticCoords( float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float W1, out float W2, out float W3 )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					W1 = temp.z;
					W2 = temp.y;
					W3 = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					W1 = -temp.z;
					W2 = 1.0 - temp.y;
					W3 = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex1 ) ) * 43758.5453 );
				UV2 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex2 ) ) * 43758.5453 );
				UV3 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex3 ) ) * 43758.5453 );
				return;
			}
			
			float4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half2 UV1, UV2, UV3;
				half W1, W2, W3;
				ComputeStochasticCoords(ZX, UV1, UV2, UV3, W1, W2, W3 );
				half4 tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZX), ddy(ZX));
				half4 tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZX), ddy(ZX));
				half4 tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZX), ddy(ZX));
				return tex1 * W1 + tex2 * W2 + tex3 * W3;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition, half3 WorldNormal )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half2 UV1, UV2, UV3;
				half W1, W2, W3;
				half4 tex1, tex2, tex3;
				ComputeStochasticCoords(ZX, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZX), ddy(ZX));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZX), ddy(ZX));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZX), ddy(ZX));
				half4 texZX = tex1 * W1 + tex2 * W2 + tex3 * W3;
				ComputeStochasticCoords(ZY, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZY), ddy(ZY));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZY), ddy(ZY));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZY), ddy(ZY));
				half4 texZY = tex1 * W1 + tex2 * W2 + tex3 * W3;
				ComputeStochasticCoords(XY, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(XY), ddy(XY));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(XY), ddy(XY));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(XY), ddy(XY));
				half4 texXY = tex1 * W1 + tex2 * W2 + tex3 * W3;
				half T1, T2, T3;
				ComputeTriplanarWeights(WorldNormal, T1, T2, T3);
				return texZX * T1 + texZY * T2 + texXY * T3;
			}
			
			float3 ASEGetEmissionHDRColor(float3 ldrColor, float luminanceIntensity, float exposureWeight, float inverseCurrentExposureMultiplier)
			{
				float3 hdrColor = ldrColor * luminanceIntensity;
				hdrColor = lerp( hdrColor* inverseCurrentExposureMultiplier, hdrColor, exposureWeight);
				return hdrColor;
			}
			
			AttributesMesh ApplyMeshModification( AttributesMesh inputMesh )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = inputMesh.positionOS.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				inputMesh.positionOS.xz = sampleCoords* _TerrainHeightmapScale.xz;
				inputMesh.positionOS.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					inputMesh.normalOS = float3(0, 1, 0);
				#else
					inputMesh.normalOS = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				inputMesh.uv0.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return inputMesh;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				surfaceData.baseColor =					surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness = 				surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

                #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

                #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
                #endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;

	            

	            
                #if ASE_SRP_VERSION >=140008
                #ifdef DECAL_NORMAL_BLENDING
					normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normalTS, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;

                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                     }
                    #endif

                    GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
                #else
					GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;
        
                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                    }
                    #endif
                #endif
                #endif
               

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
				    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				    {
					   surfaceData.metallic = 0;
				    }
				    ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData); 
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh  )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);

				inputMesh = ApplyMeshModification(inputMesh);
				float3 VertexPosition3588_g79798 = inputMesh.positionOS;
				float temp_output_84_0_g79811 = _LayerVertexValue;
				float temp_output_19_0_g79815 = TVE_VertexUsage[(int)temp_output_84_0_g79811];
				float4 temp_output_94_19_g79811 = TVE_VertexCoords;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag7344_g79798 = ase_worldPos;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV97_g79811 = ( (temp_output_94_19_g79811).zw + ( (temp_output_94_19_g79811).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode50_g79811 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g79811,temp_output_84_0_g79811, 0.0 );
				float4 temp_output_17_0_g79815 = tex2DArrayNode50_g79811;
				float4 temp_output_111_19_g79811 = TVE_VertexParams;
				float4 temp_output_3_0_g79815 = temp_output_111_19_g79811;
				float4 ifLocalVar18_g79815 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79815 >= 0.5 )
				ifLocalVar18_g79815 = temp_output_17_0_g79815;
				else
				ifLocalVar18_g79815 = temp_output_3_0_g79815;
				float4 lerpResult22_g79815 = lerp( temp_output_3_0_g79815 , temp_output_17_0_g79815 , temp_output_19_0_g79815);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79815 = lerpResult22_g79815;
				#else
				float4 staticSwitch24_g79815 = ifLocalVar18_g79815;
				#endif
				half4 Global_Vertex_Params4173_g79798 = staticSwitch24_g79815;
				float4 break322_g79802 = Global_Vertex_Params4173_g79798;
				half Global_VertexOffset7327_g79798 = break322_g79802.z;
				float3 appendResult7336_g79798 = (float3(0.0 , ( Global_VertexOffset7327_g79798 * _GlobalHeight ) , 0.0));
				half3 Vertex_Offset7335_g79798 = appendResult7336_g79798;
				float3 Vertex_Output890_g79798 = ( VertexPosition3588_g79798 + Vertex_Offset7335_g79798 );
				
				float4 appendResult7007_g79798 = (float4(cross( inputMesh.normalOS , float3(0,0,1) ) , -1.0));
				half4 Vertex_Tangents7390_g79798 = appendResult7007_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord3.xyz = ase_worldPos;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				outputPackedVaryingsMeshToPS.ase_texcoord4.xyz = ase_worldNormal;
				outputPackedVaryingsMeshToPS.ase_texcoord5.xyz = vertexToFrag7344_g79798;
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.tangentOS.xyz);
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = ase_worldTangent;
				float ase_vertexTangentSign = inputMesh.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = ase_worldBitangent;
				
				outputPackedVaryingsMeshToPS.ase_texcoord2.xy = inputMesh.uv0.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord2.zw = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord3.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord4.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord5.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Vertex_Output890_g79798;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS = Vertex_Tangents7390_g79798;

				outputPackedVaryingsMeshToPS.positionCS = UnityMetaVertexPosition(inputMesh.positionOS, inputMesh.uv1.xy, inputMesh.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);

				#ifdef EDITOR_VISUALIZATION
					float2 vizUV = 0;
					float4 lightCoord = 0;
					UnityEditorVizData(inputMesh.positionOS.xyz, inputMesh.uv0.xy, inputMesh.uv1.xy, inputMesh.uv2.xy, vizUV, lightCoord);

					outputPackedVaryingsMeshToPS.VizUV.xy = vizUV;
					outputPackedVaryingsMeshToPS.LightCoord = lightCoord;
				#endif

				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.uv3 = v.uv3;
				
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.uv3 = patch[0].uv3 * bary.x + patch[1].uv3 * bary.y + patch[2].uv3 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag(PackedVaryingsMeshToPS packedInput  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = float3(1.0, 1.0, 1.0);

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float localHeightBasedBlending7362_g83242 = ( 0.0 );
				float2 Terrain_Control_UV7873_g83242 = packedInput.ase_texcoord2.xy;
				half4 Terrain_Control_047365_g83242 = SAMPLE_TEXTURE2D( _ControlTex1, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_047362_g83242 = Terrain_Control_047365_g83242;
				half4 Terrain_Control_087366_g83242 = SAMPLE_TEXTURE2D( _ControlTex2, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_087362_g83242 = Terrain_Control_087366_g83242;
				half4 Terrain_Control_127712_g83242 = SAMPLE_TEXTURE2D( _ControlTex3, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_127362_g83242 = Terrain_Control_127712_g83242;
				half4 Terrain_Control_167711_g83242 = SAMPLE_TEXTURE2D( _ControlTex4, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_167362_g83242 = Terrain_Control_167711_g83242;
				TEXTURE2D(Texture238_g83299) = _MaskTex1;
				SamplerState Sampler238_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_016785_g83242 = _Coords1;
				float4 temp_output_37_0_g83299 = Input_Coords_016785_g83242;
				half4 Coords238_g83299 = temp_output_37_0_g83299;
				float3 ase_worldPos = packedInput.ase_texcoord3.xyz;
				half3 WorldPosition238_g83299 = ase_worldPos;
				half4 localSamplePlanar2D238_g83299 = SamplePlanar2D( Texture238_g83299 , Sampler238_g83299 , Coords238_g83299 , WorldPosition238_g83299 );
				TEXTURE2D(Texture246_g83299) = _MaskTex1;
				SamplerState Sampler246_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83299 = temp_output_37_0_g83299;
				half3 WorldPosition246_g83299 = ase_worldPos;
				float3 ase_worldNormal = packedInput.ase_texcoord4.xyz;
				half3 WorldNormal246_g83299 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83299 = SamplePlanar3D( Texture246_g83299 , Sampler246_g83299 , Coords246_g83299 , WorldPosition246_g83299 , WorldNormal246_g83299 );
				TEXTURE2D(Texture234_g83299) = _MaskTex1;
				SamplerState Sampler234_g83299 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83299 = temp_output_37_0_g83299;
				float3 WorldPosition234_g83299 = ase_worldPos;
				float4 localSampleStochastic2D234_g83299 = SampleStochastic2D( Texture234_g83299 , Sampler234_g83299 , Coords234_g83299 , WorldPosition234_g83299 );
				TEXTURE2D(Texture263_g83299) = _MaskTex1;
				SamplerState Sampler263_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83299 = temp_output_37_0_g83299;
				half3 WorldPosition263_g83299 = ase_worldPos;
				half3 WorldNormal263_g83299 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83299 = SampleStochastic3D( Texture263_g83299 , Sampler263_g83299 , Coords263_g83299 , WorldPosition263_g83299 , WorldNormal263_g83299 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8639_g83242 = localSamplePlanar2D238_g83299;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8639_g83242 = localSamplePlanar3D246_g83299;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8639_g83242 = localSampleStochastic2D234_g83299;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8639_g83242 = localSampleStochastic3D263_g83299;
				#else
				float4 staticSwitch8639_g83242 = localSamplePlanar2D238_g83299;
				#endif
				float4 temp_output_7_0_g83248 = _MaskMin1;
				float4 temp_output_10_0_g83248 = ( _MaskMax1 - temp_output_7_0_g83248 );
				float4 temp_output_6970_0_g83242 = saturate( ( ( staticSwitch8639_g83242 - temp_output_7_0_g83248 ) / ( temp_output_10_0_g83248 + 0.0001 ) ) );
				half4 Masks_015_g83256 = temp_output_6970_0_g83242;
				TEXTURE2D(Texture238_g83300) = _MaskTex2;
				SamplerState Sampler238_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_026787_g83242 = _Coords2;
				float4 temp_output_37_0_g83300 = Input_Coords_026787_g83242;
				half4 Coords238_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition238_g83300 = ase_worldPos;
				half4 localSamplePlanar2D238_g83300 = SamplePlanar2D( Texture238_g83300 , Sampler238_g83300 , Coords238_g83300 , WorldPosition238_g83300 );
				TEXTURE2D(Texture246_g83300) = _MaskTex2;
				SamplerState Sampler246_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition246_g83300 = ase_worldPos;
				half3 WorldNormal246_g83300 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83300 = SamplePlanar3D( Texture246_g83300 , Sampler246_g83300 , Coords246_g83300 , WorldPosition246_g83300 , WorldNormal246_g83300 );
				TEXTURE2D(Texture234_g83300) = _MaskTex2;
				SamplerState Sampler234_g83300 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83300 = temp_output_37_0_g83300;
				float3 WorldPosition234_g83300 = ase_worldPos;
				float4 localSampleStochastic2D234_g83300 = SampleStochastic2D( Texture234_g83300 , Sampler234_g83300 , Coords234_g83300 , WorldPosition234_g83300 );
				TEXTURE2D(Texture263_g83300) = _MaskTex2;
				SamplerState Sampler263_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition263_g83300 = ase_worldPos;
				half3 WorldNormal263_g83300 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83300 = SampleStochastic3D( Texture263_g83300 , Sampler263_g83300 , Coords263_g83300 , WorldPosition263_g83300 , WorldNormal263_g83300 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8640_g83242 = localSamplePlanar2D238_g83300;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8640_g83242 = localSamplePlanar3D246_g83300;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8640_g83242 = localSampleStochastic2D234_g83300;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8640_g83242 = localSampleStochastic3D263_g83300;
				#else
				float4 staticSwitch8640_g83242 = localSamplePlanar2D238_g83300;
				#endif
				float4 temp_output_7_0_g83250 = _MaskMin2;
				float4 temp_output_10_0_g83250 = ( _MaskMax2 - temp_output_7_0_g83250 );
				float4 temp_output_6977_0_g83242 = saturate( ( ( staticSwitch8640_g83242 - temp_output_7_0_g83250 ) / ( temp_output_10_0_g83250 + 0.0001 ) ) );
				half4 Masks_0210_g83256 = temp_output_6977_0_g83242;
				TEXTURE2D(Texture238_g83301) = _MaskTex3;
				SamplerState Sampler238_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_036789_g83242 = _Coords3;
				float4 temp_output_37_0_g83301 = Input_Coords_036789_g83242;
				half4 Coords238_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition238_g83301 = ase_worldPos;
				half4 localSamplePlanar2D238_g83301 = SamplePlanar2D( Texture238_g83301 , Sampler238_g83301 , Coords238_g83301 , WorldPosition238_g83301 );
				TEXTURE2D(Texture246_g83301) = _MaskTex3;
				SamplerState Sampler246_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition246_g83301 = ase_worldPos;
				half3 WorldNormal246_g83301 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83301 = SamplePlanar3D( Texture246_g83301 , Sampler246_g83301 , Coords246_g83301 , WorldPosition246_g83301 , WorldNormal246_g83301 );
				TEXTURE2D(Texture234_g83301) = _MaskTex3;
				SamplerState Sampler234_g83301 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83301 = temp_output_37_0_g83301;
				float3 WorldPosition234_g83301 = ase_worldPos;
				float4 localSampleStochastic2D234_g83301 = SampleStochastic2D( Texture234_g83301 , Sampler234_g83301 , Coords234_g83301 , WorldPosition234_g83301 );
				TEXTURE2D(Texture263_g83301) = _MaskTex3;
				SamplerState Sampler263_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition263_g83301 = ase_worldPos;
				half3 WorldNormal263_g83301 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83301 = SampleStochastic3D( Texture263_g83301 , Sampler263_g83301 , Coords263_g83301 , WorldPosition263_g83301 , WorldNormal263_g83301 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8641_g83242 = localSamplePlanar2D238_g83301;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8641_g83242 = localSamplePlanar3D246_g83301;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8641_g83242 = localSampleStochastic2D234_g83301;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8641_g83242 = localSampleStochastic3D263_g83301;
				#else
				float4 staticSwitch8641_g83242 = localSamplePlanar2D238_g83301;
				#endif
				float4 temp_output_7_0_g83251 = _MaskMin3;
				float4 temp_output_10_0_g83251 = ( _MaskMax3 - temp_output_7_0_g83251 );
				float4 temp_output_6978_0_g83242 = saturate( ( ( staticSwitch8641_g83242 - temp_output_7_0_g83251 ) / ( temp_output_10_0_g83251 + 0.0001 ) ) );
				half4 Masks_0312_g83256 = temp_output_6978_0_g83242;
				TEXTURE2D(Texture238_g83302) = _MaskTex4;
				SamplerState Sampler238_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_046791_g83242 = _Coords4;
				float4 temp_output_37_0_g83302 = Input_Coords_046791_g83242;
				half4 Coords238_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition238_g83302 = ase_worldPos;
				half4 localSamplePlanar2D238_g83302 = SamplePlanar2D( Texture238_g83302 , Sampler238_g83302 , Coords238_g83302 , WorldPosition238_g83302 );
				TEXTURE2D(Texture246_g83302) = _MaskTex4;
				SamplerState Sampler246_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition246_g83302 = ase_worldPos;
				half3 WorldNormal246_g83302 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83302 = SamplePlanar3D( Texture246_g83302 , Sampler246_g83302 , Coords246_g83302 , WorldPosition246_g83302 , WorldNormal246_g83302 );
				TEXTURE2D(Texture234_g83302) = _MaskTex4;
				SamplerState Sampler234_g83302 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83302 = temp_output_37_0_g83302;
				float3 WorldPosition234_g83302 = ase_worldPos;
				float4 localSampleStochastic2D234_g83302 = SampleStochastic2D( Texture234_g83302 , Sampler234_g83302 , Coords234_g83302 , WorldPosition234_g83302 );
				TEXTURE2D(Texture263_g83302) = _MaskTex4;
				SamplerState Sampler263_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition263_g83302 = ase_worldPos;
				half3 WorldNormal263_g83302 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83302 = SampleStochastic3D( Texture263_g83302 , Sampler263_g83302 , Coords263_g83302 , WorldPosition263_g83302 , WorldNormal263_g83302 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8642_g83242 = localSamplePlanar2D238_g83302;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8642_g83242 = localSamplePlanar3D246_g83302;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8642_g83242 = localSampleStochastic2D234_g83302;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8642_g83242 = localSampleStochastic3D263_g83302;
				#else
				float4 staticSwitch8642_g83242 = localSamplePlanar2D238_g83302;
				#endif
				float4 temp_output_7_0_g83252 = _MaskMin4;
				float4 temp_output_10_0_g83252 = ( _MaskMax4 - temp_output_7_0_g83252 );
				float4 temp_output_6983_0_g83242 = saturate( ( ( staticSwitch8642_g83242 - temp_output_7_0_g83252 ) / ( temp_output_10_0_g83252 + 0.0001 ) ) );
				half4 Masks_0414_g83256 = temp_output_6983_0_g83242;
				float4 appendResult29_g83256 = (float4((Masks_015_g83256).z , (Masks_0210_g83256).z , (Masks_0312_g83256).z , (Masks_0414_g83256).z));
				half4 Control31_g83256 = Terrain_Control_047365_g83242;
				half4 Terrain_Height_047210_g83242 = ( appendResult29_g83256 * Control31_g83256 );
				float4 heights_047362_g83242 = Terrain_Height_047210_g83242;
				TEXTURE2D(Texture238_g83311) = _MaskTex5;
				SamplerState Sampler238_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_058750_g83242 = _Coords5;
				float4 temp_output_37_0_g83311 = Input_Coords_058750_g83242;
				half4 Coords238_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition238_g83311 = ase_worldPos;
				half4 localSamplePlanar2D238_g83311 = SamplePlanar2D( Texture238_g83311 , Sampler238_g83311 , Coords238_g83311 , WorldPosition238_g83311 );
				TEXTURE2D(Texture246_g83311) = _MaskTex5;
				SamplerState Sampler246_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition246_g83311 = ase_worldPos;
				half3 WorldNormal246_g83311 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83311 = SamplePlanar3D( Texture246_g83311 , Sampler246_g83311 , Coords246_g83311 , WorldPosition246_g83311 , WorldNormal246_g83311 );
				TEXTURE2D(Texture234_g83311) = _MaskTex5;
				SamplerState Sampler234_g83311 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83311 = temp_output_37_0_g83311;
				float3 WorldPosition234_g83311 = ase_worldPos;
				float4 localSampleStochastic2D234_g83311 = SampleStochastic2D( Texture234_g83311 , Sampler234_g83311 , Coords234_g83311 , WorldPosition234_g83311 );
				TEXTURE2D(Texture263_g83311) = _MaskTex5;
				SamplerState Sampler263_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition263_g83311 = ase_worldPos;
				half3 WorldNormal263_g83311 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83311 = SampleStochastic3D( Texture263_g83311 , Sampler263_g83311 , Coords263_g83311 , WorldPosition263_g83311 , WorldNormal263_g83311 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8710_g83242 = localSamplePlanar2D238_g83311;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8710_g83242 = localSamplePlanar3D246_g83311;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8710_g83242 = localSampleStochastic2D234_g83311;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8710_g83242 = localSampleStochastic3D263_g83311;
				#else
				float4 staticSwitch8710_g83242 = localSamplePlanar2D238_g83311;
				#endif
				float4 temp_output_7_0_g83264 = _MaskMin5;
				float4 temp_output_10_0_g83264 = ( _MaskMax5 - temp_output_7_0_g83264 );
				float4 temp_output_8714_0_g83242 = saturate( ( ( staticSwitch8710_g83242 - temp_output_7_0_g83264 ) / ( temp_output_10_0_g83264 + 0.0001 ) ) );
				half4 Masks_015_g83265 = temp_output_8714_0_g83242;
				TEXTURE2D(Texture238_g83312) = _MaskTex6;
				SamplerState Sampler238_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_068751_g83242 = _Coords6;
				float4 temp_output_37_0_g83312 = Input_Coords_068751_g83242;
				half4 Coords238_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition238_g83312 = ase_worldPos;
				half4 localSamplePlanar2D238_g83312 = SamplePlanar2D( Texture238_g83312 , Sampler238_g83312 , Coords238_g83312 , WorldPosition238_g83312 );
				TEXTURE2D(Texture246_g83312) = _MaskTex6;
				SamplerState Sampler246_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition246_g83312 = ase_worldPos;
				half3 WorldNormal246_g83312 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83312 = SamplePlanar3D( Texture246_g83312 , Sampler246_g83312 , Coords246_g83312 , WorldPosition246_g83312 , WorldNormal246_g83312 );
				TEXTURE2D(Texture234_g83312) = _MaskTex6;
				SamplerState Sampler234_g83312 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83312 = temp_output_37_0_g83312;
				float3 WorldPosition234_g83312 = ase_worldPos;
				float4 localSampleStochastic2D234_g83312 = SampleStochastic2D( Texture234_g83312 , Sampler234_g83312 , Coords234_g83312 , WorldPosition234_g83312 );
				TEXTURE2D(Texture263_g83312) = _MaskTex6;
				SamplerState Sampler263_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition263_g83312 = ase_worldPos;
				half3 WorldNormal263_g83312 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83312 = SampleStochastic3D( Texture263_g83312 , Sampler263_g83312 , Coords263_g83312 , WorldPosition263_g83312 , WorldNormal263_g83312 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8711_g83242 = localSamplePlanar2D238_g83312;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8711_g83242 = localSamplePlanar3D246_g83312;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8711_g83242 = localSampleStochastic2D234_g83312;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8711_g83242 = localSampleStochastic3D263_g83312;
				#else
				float4 staticSwitch8711_g83242 = localSamplePlanar2D238_g83312;
				#endif
				float4 temp_output_7_0_g83267 = _MaskMin6;
				float4 temp_output_10_0_g83267 = ( _MaskMax6 - temp_output_7_0_g83267 );
				float4 temp_output_8721_0_g83242 = saturate( ( ( staticSwitch8711_g83242 - temp_output_7_0_g83267 ) / ( temp_output_10_0_g83267 + 0.0001 ) ) );
				half4 Masks_0210_g83265 = temp_output_8721_0_g83242;
				TEXTURE2D(Texture238_g83313) = _MaskTex7;
				SamplerState Sampler238_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_078752_g83242 = _Coords7;
				float4 temp_output_37_0_g83313 = Input_Coords_078752_g83242;
				half4 Coords238_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition238_g83313 = ase_worldPos;
				half4 localSamplePlanar2D238_g83313 = SamplePlanar2D( Texture238_g83313 , Sampler238_g83313 , Coords238_g83313 , WorldPosition238_g83313 );
				TEXTURE2D(Texture246_g83313) = _MaskTex7;
				SamplerState Sampler246_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition246_g83313 = ase_worldPos;
				half3 WorldNormal246_g83313 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83313 = SamplePlanar3D( Texture246_g83313 , Sampler246_g83313 , Coords246_g83313 , WorldPosition246_g83313 , WorldNormal246_g83313 );
				TEXTURE2D(Texture234_g83313) = _MaskTex7;
				SamplerState Sampler234_g83313 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83313 = temp_output_37_0_g83313;
				float3 WorldPosition234_g83313 = ase_worldPos;
				float4 localSampleStochastic2D234_g83313 = SampleStochastic2D( Texture234_g83313 , Sampler234_g83313 , Coords234_g83313 , WorldPosition234_g83313 );
				TEXTURE2D(Texture263_g83313) = _MaskTex7;
				SamplerState Sampler263_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition263_g83313 = ase_worldPos;
				half3 WorldNormal263_g83313 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83313 = SampleStochastic3D( Texture263_g83313 , Sampler263_g83313 , Coords263_g83313 , WorldPosition263_g83313 , WorldNormal263_g83313 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8712_g83242 = localSamplePlanar2D238_g83313;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8712_g83242 = localSamplePlanar3D246_g83313;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8712_g83242 = localSampleStochastic2D234_g83313;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8712_g83242 = localSampleStochastic3D263_g83313;
				#else
				float4 staticSwitch8712_g83242 = localSamplePlanar2D238_g83313;
				#endif
				float4 temp_output_7_0_g83268 = _MaskMin7;
				float4 temp_output_10_0_g83268 = ( _MaskMax7 - temp_output_7_0_g83268 );
				float4 temp_output_8724_0_g83242 = saturate( ( ( staticSwitch8712_g83242 - temp_output_7_0_g83268 ) / ( temp_output_10_0_g83268 + 0.0001 ) ) );
				half4 Masks_0312_g83265 = temp_output_8724_0_g83242;
				TEXTURE2D(Texture238_g83314) = _MaskTex8;
				SamplerState Sampler238_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_088749_g83242 = _Coords8;
				float4 temp_output_37_0_g83314 = Input_Coords_088749_g83242;
				half4 Coords238_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition238_g83314 = ase_worldPos;
				half4 localSamplePlanar2D238_g83314 = SamplePlanar2D( Texture238_g83314 , Sampler238_g83314 , Coords238_g83314 , WorldPosition238_g83314 );
				TEXTURE2D(Texture246_g83314) = _MaskTex8;
				SamplerState Sampler246_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition246_g83314 = ase_worldPos;
				half3 WorldNormal246_g83314 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83314 = SamplePlanar3D( Texture246_g83314 , Sampler246_g83314 , Coords246_g83314 , WorldPosition246_g83314 , WorldNormal246_g83314 );
				TEXTURE2D(Texture234_g83314) = _MaskTex8;
				SamplerState Sampler234_g83314 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83314 = temp_output_37_0_g83314;
				float3 WorldPosition234_g83314 = ase_worldPos;
				float4 localSampleStochastic2D234_g83314 = SampleStochastic2D( Texture234_g83314 , Sampler234_g83314 , Coords234_g83314 , WorldPosition234_g83314 );
				TEXTURE2D(Texture263_g83314) = _MaskTex8;
				SamplerState Sampler263_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition263_g83314 = ase_worldPos;
				half3 WorldNormal263_g83314 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83314 = SampleStochastic3D( Texture263_g83314 , Sampler263_g83314 , Coords263_g83314 , WorldPosition263_g83314 , WorldNormal263_g83314 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8713_g83242 = localSamplePlanar2D238_g83314;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8713_g83242 = localSamplePlanar3D246_g83314;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8713_g83242 = localSampleStochastic2D234_g83314;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8713_g83242 = localSampleStochastic3D263_g83314;
				#else
				float4 staticSwitch8713_g83242 = localSamplePlanar2D238_g83314;
				#endif
				float4 temp_output_7_0_g83269 = _MaskMin8;
				float4 temp_output_10_0_g83269 = ( _MaskMax8 - temp_output_7_0_g83269 );
				float4 temp_output_8727_0_g83242 = saturate( ( ( staticSwitch8713_g83242 - temp_output_7_0_g83269 ) / ( temp_output_10_0_g83269 + 0.0001 ) ) );
				half4 Masks_0414_g83265 = temp_output_8727_0_g83242;
				float4 appendResult29_g83265 = (float4((Masks_015_g83265).z , (Masks_0210_g83265).z , (Masks_0312_g83265).z , (Masks_0414_g83265).z));
				half4 Control31_g83265 = Terrain_Control_087366_g83242;
				half4 Terrain_Height_088731_g83242 = ( appendResult29_g83265 * Control31_g83265 );
				float4 heights_087362_g83242 = Terrain_Height_088731_g83242;
				TEXTURE2D(Texture238_g83323) = _MaskTex9;
				SamplerState Sampler238_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_098833_g83242 = _Coords9;
				float4 temp_output_37_0_g83323 = Input_Coords_098833_g83242;
				half4 Coords238_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition238_g83323 = ase_worldPos;
				half4 localSamplePlanar2D238_g83323 = SamplePlanar2D( Texture238_g83323 , Sampler238_g83323 , Coords238_g83323 , WorldPosition238_g83323 );
				TEXTURE2D(Texture246_g83323) = _MaskTex9;
				SamplerState Sampler246_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition246_g83323 = ase_worldPos;
				half3 WorldNormal246_g83323 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83323 = SamplePlanar3D( Texture246_g83323 , Sampler246_g83323 , Coords246_g83323 , WorldPosition246_g83323 , WorldNormal246_g83323 );
				TEXTURE2D(Texture234_g83323) = _MaskTex9;
				SamplerState Sampler234_g83323 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83323 = temp_output_37_0_g83323;
				float3 WorldPosition234_g83323 = ase_worldPos;
				float4 localSampleStochastic2D234_g83323 = SampleStochastic2D( Texture234_g83323 , Sampler234_g83323 , Coords234_g83323 , WorldPosition234_g83323 );
				TEXTURE2D(Texture263_g83323) = _MaskTex9;
				SamplerState Sampler263_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition263_g83323 = ase_worldPos;
				half3 WorldNormal263_g83323 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83323 = SampleStochastic3D( Texture263_g83323 , Sampler263_g83323 , Coords263_g83323 , WorldPosition263_g83323 , WorldNormal263_g83323 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8878_g83242 = localSamplePlanar2D238_g83323;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8878_g83242 = localSamplePlanar3D246_g83323;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8878_g83242 = localSampleStochastic2D234_g83323;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8878_g83242 = localSampleStochastic3D263_g83323;
				#else
				float4 staticSwitch8878_g83242 = localSamplePlanar2D238_g83323;
				#endif
				float4 temp_output_7_0_g83274 = _MaskMin9;
				float4 temp_output_10_0_g83274 = ( _MaskMax9 - temp_output_7_0_g83274 );
				float4 temp_output_8815_0_g83242 = saturate( ( ( staticSwitch8878_g83242 - temp_output_7_0_g83274 ) / ( temp_output_10_0_g83274 + 0.0001 ) ) );
				half4 Masks_015_g83275 = temp_output_8815_0_g83242;
				TEXTURE2D(Texture238_g83324) = _MaskTex10;
				SamplerState Sampler238_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_108834_g83242 = _Coords10;
				float4 temp_output_37_0_g83324 = Input_Coords_108834_g83242;
				half4 Coords238_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition238_g83324 = ase_worldPos;
				half4 localSamplePlanar2D238_g83324 = SamplePlanar2D( Texture238_g83324 , Sampler238_g83324 , Coords238_g83324 , WorldPosition238_g83324 );
				TEXTURE2D(Texture246_g83324) = _MaskTex10;
				SamplerState Sampler246_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition246_g83324 = ase_worldPos;
				half3 WorldNormal246_g83324 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83324 = SamplePlanar3D( Texture246_g83324 , Sampler246_g83324 , Coords246_g83324 , WorldPosition246_g83324 , WorldNormal246_g83324 );
				TEXTURE2D(Texture234_g83324) = _MaskTex10;
				SamplerState Sampler234_g83324 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83324 = temp_output_37_0_g83324;
				float3 WorldPosition234_g83324 = ase_worldPos;
				float4 localSampleStochastic2D234_g83324 = SampleStochastic2D( Texture234_g83324 , Sampler234_g83324 , Coords234_g83324 , WorldPosition234_g83324 );
				TEXTURE2D(Texture263_g83324) = _MaskTex10;
				SamplerState Sampler263_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition263_g83324 = ase_worldPos;
				half3 WorldNormal263_g83324 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83324 = SampleStochastic3D( Texture263_g83324 , Sampler263_g83324 , Coords263_g83324 , WorldPosition263_g83324 , WorldNormal263_g83324 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8860_g83242 = localSamplePlanar2D238_g83324;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8860_g83242 = localSamplePlanar3D246_g83324;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8860_g83242 = localSampleStochastic2D234_g83324;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8860_g83242 = localSampleStochastic3D263_g83324;
				#else
				float4 staticSwitch8860_g83242 = localSamplePlanar2D238_g83324;
				#endif
				float4 temp_output_7_0_g83277 = _MaskMin10;
				float4 temp_output_10_0_g83277 = ( _MaskMax10 - temp_output_7_0_g83277 );
				float4 temp_output_8818_0_g83242 = saturate( ( ( staticSwitch8860_g83242 - temp_output_7_0_g83277 ) / ( temp_output_10_0_g83277 + 0.0001 ) ) );
				half4 Masks_0210_g83275 = temp_output_8818_0_g83242;
				TEXTURE2D(Texture238_g83325) = _MaskTex11;
				SamplerState Sampler238_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_118835_g83242 = _Coords11;
				float4 temp_output_37_0_g83325 = Input_Coords_118835_g83242;
				half4 Coords238_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition238_g83325 = ase_worldPos;
				half4 localSamplePlanar2D238_g83325 = SamplePlanar2D( Texture238_g83325 , Sampler238_g83325 , Coords238_g83325 , WorldPosition238_g83325 );
				TEXTURE2D(Texture246_g83325) = _MaskTex11;
				SamplerState Sampler246_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition246_g83325 = ase_worldPos;
				half3 WorldNormal246_g83325 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83325 = SamplePlanar3D( Texture246_g83325 , Sampler246_g83325 , Coords246_g83325 , WorldPosition246_g83325 , WorldNormal246_g83325 );
				TEXTURE2D(Texture234_g83325) = _MaskTex11;
				SamplerState Sampler234_g83325 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83325 = temp_output_37_0_g83325;
				float3 WorldPosition234_g83325 = ase_worldPos;
				float4 localSampleStochastic2D234_g83325 = SampleStochastic2D( Texture234_g83325 , Sampler234_g83325 , Coords234_g83325 , WorldPosition234_g83325 );
				TEXTURE2D(Texture263_g83325) = _MaskTex11;
				SamplerState Sampler263_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition263_g83325 = ase_worldPos;
				half3 WorldNormal263_g83325 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83325 = SampleStochastic3D( Texture263_g83325 , Sampler263_g83325 , Coords263_g83325 , WorldPosition263_g83325 , WorldNormal263_g83325 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8861_g83242 = localSamplePlanar2D238_g83325;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8861_g83242 = localSamplePlanar3D246_g83325;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8861_g83242 = localSampleStochastic2D234_g83325;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8861_g83242 = localSampleStochastic3D263_g83325;
				#else
				float4 staticSwitch8861_g83242 = localSamplePlanar2D238_g83325;
				#endif
				float4 temp_output_7_0_g83278 = _MaskMin11;
				float4 temp_output_10_0_g83278 = ( _MaskMax11 - temp_output_7_0_g83278 );
				float4 temp_output_8819_0_g83242 = saturate( ( ( staticSwitch8861_g83242 - temp_output_7_0_g83278 ) / ( temp_output_10_0_g83278 + 0.0001 ) ) );
				half4 Masks_0312_g83275 = temp_output_8819_0_g83242;
				TEXTURE2D(Texture238_g83326) = _MaskTex12;
				SamplerState Sampler238_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_128836_g83242 = _Coords12;
				float4 temp_output_37_0_g83326 = Input_Coords_128836_g83242;
				half4 Coords238_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition238_g83326 = ase_worldPos;
				half4 localSamplePlanar2D238_g83326 = SamplePlanar2D( Texture238_g83326 , Sampler238_g83326 , Coords238_g83326 , WorldPosition238_g83326 );
				TEXTURE2D(Texture246_g83326) = _MaskTex12;
				SamplerState Sampler246_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition246_g83326 = ase_worldPos;
				half3 WorldNormal246_g83326 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83326 = SamplePlanar3D( Texture246_g83326 , Sampler246_g83326 , Coords246_g83326 , WorldPosition246_g83326 , WorldNormal246_g83326 );
				TEXTURE2D(Texture234_g83326) = _MaskTex12;
				SamplerState Sampler234_g83326 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83326 = temp_output_37_0_g83326;
				float3 WorldPosition234_g83326 = ase_worldPos;
				float4 localSampleStochastic2D234_g83326 = SampleStochastic2D( Texture234_g83326 , Sampler234_g83326 , Coords234_g83326 , WorldPosition234_g83326 );
				TEXTURE2D(Texture263_g83326) = _MaskTex12;
				SamplerState Sampler263_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition263_g83326 = ase_worldPos;
				half3 WorldNormal263_g83326 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83326 = SampleStochastic3D( Texture263_g83326 , Sampler263_g83326 , Coords263_g83326 , WorldPosition263_g83326 , WorldNormal263_g83326 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8879_g83242 = localSamplePlanar2D238_g83326;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8879_g83242 = localSamplePlanar3D246_g83326;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8879_g83242 = localSampleStochastic2D234_g83326;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8879_g83242 = localSampleStochastic3D263_g83326;
				#else
				float4 staticSwitch8879_g83242 = localSamplePlanar2D238_g83326;
				#endif
				float4 temp_output_7_0_g83279 = _MaskMin12;
				float4 temp_output_10_0_g83279 = ( _MaskMax12 - temp_output_7_0_g83279 );
				float4 temp_output_8820_0_g83242 = saturate( ( ( staticSwitch8879_g83242 - temp_output_7_0_g83279 ) / ( temp_output_10_0_g83279 + 0.0001 ) ) );
				half4 Masks_0414_g83275 = temp_output_8820_0_g83242;
				float4 appendResult29_g83275 = (float4((Masks_015_g83275).z , (Masks_0210_g83275).z , (Masks_0312_g83275).z , (Masks_0414_g83275).z));
				half4 Control31_g83275 = Terrain_Control_127712_g83242;
				half4 Terrain_Height_128870_g83242 = ( appendResult29_g83275 * Control31_g83275 );
				float4 heights_127362_g83242 = Terrain_Height_128870_g83242;
				TEXTURE2D(Texture238_g83334) = _MaskTex13;
				SamplerState Sampler238_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_138960_g83242 = _Coords13;
				float4 temp_output_37_0_g83334 = Input_Coords_138960_g83242;
				half4 Coords238_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition238_g83334 = ase_worldPos;
				half4 localSamplePlanar2D238_g83334 = SamplePlanar2D( Texture238_g83334 , Sampler238_g83334 , Coords238_g83334 , WorldPosition238_g83334 );
				TEXTURE2D(Texture246_g83334) = _MaskTex13;
				SamplerState Sampler246_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition246_g83334 = ase_worldPos;
				half3 WorldNormal246_g83334 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83334 = SamplePlanar3D( Texture246_g83334 , Sampler246_g83334 , Coords246_g83334 , WorldPosition246_g83334 , WorldNormal246_g83334 );
				TEXTURE2D(Texture234_g83334) = _MaskTex13;
				SamplerState Sampler234_g83334 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83334 = temp_output_37_0_g83334;
				float3 WorldPosition234_g83334 = ase_worldPos;
				float4 localSampleStochastic2D234_g83334 = SampleStochastic2D( Texture234_g83334 , Sampler234_g83334 , Coords234_g83334 , WorldPosition234_g83334 );
				TEXTURE2D(Texture263_g83334) = _MaskTex13;
				SamplerState Sampler263_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition263_g83334 = ase_worldPos;
				half3 WorldNormal263_g83334 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83334 = SampleStochastic3D( Texture263_g83334 , Sampler263_g83334 , Coords263_g83334 , WorldPosition263_g83334 , WorldNormal263_g83334 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch9000_g83242 = localSamplePlanar2D238_g83334;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch9000_g83242 = localSamplePlanar3D246_g83334;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch9000_g83242 = localSampleStochastic2D234_g83334;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch9000_g83242 = localSampleStochastic3D263_g83334;
				#else
				float4 staticSwitch9000_g83242 = localSamplePlanar2D238_g83334;
				#endif
				float4 temp_output_7_0_g83284 = _MaskMin13;
				float4 temp_output_10_0_g83284 = ( _MaskMax13 - temp_output_7_0_g83284 );
				float4 temp_output_8931_0_g83242 = saturate( ( ( staticSwitch9000_g83242 - temp_output_7_0_g83284 ) / ( temp_output_10_0_g83284 + 0.0001 ) ) );
				half4 Masks_015_g83285 = temp_output_8931_0_g83242;
				TEXTURE2D(Texture238_g83335) = _MaskTex14;
				SamplerState Sampler238_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_148961_g83242 = _Coords14;
				float4 temp_output_37_0_g83335 = Input_Coords_148961_g83242;
				half4 Coords238_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition238_g83335 = ase_worldPos;
				half4 localSamplePlanar2D238_g83335 = SamplePlanar2D( Texture238_g83335 , Sampler238_g83335 , Coords238_g83335 , WorldPosition238_g83335 );
				TEXTURE2D(Texture246_g83335) = _MaskTex14;
				SamplerState Sampler246_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition246_g83335 = ase_worldPos;
				half3 WorldNormal246_g83335 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83335 = SamplePlanar3D( Texture246_g83335 , Sampler246_g83335 , Coords246_g83335 , WorldPosition246_g83335 , WorldNormal246_g83335 );
				TEXTURE2D(Texture234_g83335) = _MaskTex14;
				SamplerState Sampler234_g83335 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83335 = temp_output_37_0_g83335;
				float3 WorldPosition234_g83335 = ase_worldPos;
				float4 localSampleStochastic2D234_g83335 = SampleStochastic2D( Texture234_g83335 , Sampler234_g83335 , Coords234_g83335 , WorldPosition234_g83335 );
				TEXTURE2D(Texture263_g83335) = _MaskTex14;
				SamplerState Sampler263_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition263_g83335 = ase_worldPos;
				half3 WorldNormal263_g83335 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83335 = SampleStochastic3D( Texture263_g83335 , Sampler263_g83335 , Coords263_g83335 , WorldPosition263_g83335 , WorldNormal263_g83335 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch9001_g83242 = localSamplePlanar2D238_g83335;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch9001_g83242 = localSamplePlanar3D246_g83335;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch9001_g83242 = localSampleStochastic2D234_g83335;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch9001_g83242 = localSampleStochastic3D263_g83335;
				#else
				float4 staticSwitch9001_g83242 = localSamplePlanar2D238_g83335;
				#endif
				float4 temp_output_7_0_g83287 = _MaskMin14;
				float4 temp_output_10_0_g83287 = ( _MaskMax14 - temp_output_7_0_g83287 );
				float4 temp_output_8934_0_g83242 = saturate( ( ( staticSwitch9001_g83242 - temp_output_7_0_g83287 ) / ( temp_output_10_0_g83287 + 0.0001 ) ) );
				half4 Masks_0210_g83285 = temp_output_8934_0_g83242;
				TEXTURE2D(Texture238_g83336) = _MaskTex15;
				SamplerState Sampler238_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_158962_g83242 = _Coords15;
				float4 temp_output_37_0_g83336 = Input_Coords_158962_g83242;
				half4 Coords238_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition238_g83336 = ase_worldPos;
				half4 localSamplePlanar2D238_g83336 = SamplePlanar2D( Texture238_g83336 , Sampler238_g83336 , Coords238_g83336 , WorldPosition238_g83336 );
				TEXTURE2D(Texture246_g83336) = _MaskTex15;
				SamplerState Sampler246_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition246_g83336 = ase_worldPos;
				half3 WorldNormal246_g83336 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83336 = SamplePlanar3D( Texture246_g83336 , Sampler246_g83336 , Coords246_g83336 , WorldPosition246_g83336 , WorldNormal246_g83336 );
				TEXTURE2D(Texture234_g83336) = _MaskTex15;
				SamplerState Sampler234_g83336 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83336 = temp_output_37_0_g83336;
				float3 WorldPosition234_g83336 = ase_worldPos;
				float4 localSampleStochastic2D234_g83336 = SampleStochastic2D( Texture234_g83336 , Sampler234_g83336 , Coords234_g83336 , WorldPosition234_g83336 );
				TEXTURE2D(Texture263_g83336) = _MaskTex15;
				SamplerState Sampler263_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition263_g83336 = ase_worldPos;
				half3 WorldNormal263_g83336 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83336 = SampleStochastic3D( Texture263_g83336 , Sampler263_g83336 , Coords263_g83336 , WorldPosition263_g83336 , WorldNormal263_g83336 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch9002_g83242 = localSamplePlanar2D238_g83336;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch9002_g83242 = localSamplePlanar3D246_g83336;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch9002_g83242 = localSampleStochastic2D234_g83336;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch9002_g83242 = localSampleStochastic3D263_g83336;
				#else
				float4 staticSwitch9002_g83242 = localSamplePlanar2D238_g83336;
				#endif
				float4 temp_output_7_0_g83288 = _MaskMin15;
				float4 temp_output_10_0_g83288 = ( _MaskMax15 - temp_output_7_0_g83288 );
				float4 temp_output_8935_0_g83242 = saturate( ( ( staticSwitch9002_g83242 - temp_output_7_0_g83288 ) / ( temp_output_10_0_g83288 + 0.0001 ) ) );
				half4 Masks_0312_g83285 = temp_output_8935_0_g83242;
				TEXTURE2D(Texture238_g83337) = _MaskTex16;
				SamplerState Sampler238_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_168959_g83242 = _Coords16;
				float4 temp_output_37_0_g83337 = Input_Coords_168959_g83242;
				half4 Coords238_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition238_g83337 = ase_worldPos;
				half4 localSamplePlanar2D238_g83337 = SamplePlanar2D( Texture238_g83337 , Sampler238_g83337 , Coords238_g83337 , WorldPosition238_g83337 );
				TEXTURE2D(Texture246_g83337) = _MaskTex16;
				SamplerState Sampler246_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition246_g83337 = ase_worldPos;
				half3 WorldNormal246_g83337 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83337 = SamplePlanar3D( Texture246_g83337 , Sampler246_g83337 , Coords246_g83337 , WorldPosition246_g83337 , WorldNormal246_g83337 );
				TEXTURE2D(Texture234_g83337) = _MaskTex16;
				SamplerState Sampler234_g83337 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83337 = temp_output_37_0_g83337;
				float3 WorldPosition234_g83337 = ase_worldPos;
				float4 localSampleStochastic2D234_g83337 = SampleStochastic2D( Texture234_g83337 , Sampler234_g83337 , Coords234_g83337 , WorldPosition234_g83337 );
				TEXTURE2D(Texture263_g83337) = _MaskTex16;
				SamplerState Sampler263_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition263_g83337 = ase_worldPos;
				half3 WorldNormal263_g83337 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83337 = SampleStochastic3D( Texture263_g83337 , Sampler263_g83337 , Coords263_g83337 , WorldPosition263_g83337 , WorldNormal263_g83337 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch9003_g83242 = localSamplePlanar2D238_g83337;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch9003_g83242 = localSamplePlanar3D246_g83337;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch9003_g83242 = localSampleStochastic2D234_g83337;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch9003_g83242 = localSampleStochastic3D263_g83337;
				#else
				float4 staticSwitch9003_g83242 = localSamplePlanar2D238_g83337;
				#endif
				float4 temp_output_7_0_g83289 = _MaskMin16;
				float4 temp_output_10_0_g83289 = ( _MaskMax16 - temp_output_7_0_g83289 );
				float4 temp_output_8936_0_g83242 = saturate( ( ( staticSwitch9003_g83242 - temp_output_7_0_g83289 ) / ( temp_output_10_0_g83289 + 0.0001 ) ) );
				half4 Masks_0414_g83285 = temp_output_8936_0_g83242;
				float4 appendResult29_g83285 = (float4((Masks_015_g83285).z , (Masks_0210_g83285).z , (Masks_0312_g83285).z , (Masks_0414_g83285).z));
				half4 Control31_g83285 = Terrain_Control_167711_g83242;
				half4 Terrain_Height_169015_g83242 = ( appendResult29_g83285 * Control31_g83285 );
				float4 heights_167362_g83242 = Terrain_Height_169015_g83242;
				float heightTransition7362_g83242 = ( 1.0 - _TerrainHeightBlendValue );
				float4 weights_047362_g83242 = float4( 0,0,0,0 );
				float4 weights_087362_g83242 = float4( 0,0,0,0 );
				float4 weights_127362_g83242 = float4( 0,0,0,0 );
				float4 weights_167362_g83242 = float4( 0,0,0,0 );
				{
				//Modified version of the HDRP terrain height based blending
				float maxHeight = 0;
				float4 weightedHeights_04 = float4( 0,0,0,0 );
				float4 weightedHeights_08 = float4( 0,0,0,0 );
				float4 weightedHeights_12 = float4( 0,0,0,0 );
				float4 weightedHeights_16 = float4( 0,0,0,0 );
				maxHeight = heights_047362_g83242.x;
				maxHeight = max(maxHeight, heights_047362_g83242.y);
				maxHeight = max(maxHeight, heights_047362_g83242.z);
				maxHeight = max(maxHeight, heights_047362_g83242.w);
				#ifdef TVE_TERRAIN_08
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				#endif
				#ifdef TVE_TERRAIN_12
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				maxHeight = max(maxHeight, heights_127362_g83242.x);
				maxHeight = max(maxHeight, heights_127362_g83242.y);
				maxHeight = max(maxHeight, heights_127362_g83242.z);
				maxHeight = max(maxHeight, heights_127362_g83242.w);
				#endif
				#ifdef TVE_TERRAIN_16
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				maxHeight = max(maxHeight, heights_127362_g83242.x);
				maxHeight = max(maxHeight, heights_127362_g83242.y);
				maxHeight = max(maxHeight, heights_127362_g83242.z);
				maxHeight = max(maxHeight, heights_127362_g83242.w);
				maxHeight = max(maxHeight, heights_167362_g83242.x);
				maxHeight = max(maxHeight, heights_167362_g83242.y);
				maxHeight = max(maxHeight, heights_167362_g83242.z);
				maxHeight = max(maxHeight, heights_167362_g83242.w);
				#endif
				float transition = max(heightTransition7362_g83242, 0.01);
				weightedHeights_04 = float4 ( heights_047362_g83242.x, heights_047362_g83242.y, heights_047362_g83242.z, heights_047362_g83242.w );
				weightedHeights_04 = weightedHeights_04 - maxHeight.xxxx;
				weightedHeights_04 = (max(0, weightedHeights_04 + transition) + 1e-6) * control_047362_g83242;
				#ifdef TVE_TERRAIN_08
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				#endif
				#ifdef TVE_TERRAIN_12
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				weightedHeights_12 = float4 ( heights_127362_g83242.x, heights_127362_g83242.y, heights_127362_g83242.z, heights_127362_g83242.w );
				weightedHeights_12 = weightedHeights_12 - maxHeight.xxxx;
				weightedHeights_12 = (max(0, weightedHeights_12 + transition) + 1e-6) * control_127362_g83242;
				#endif
				#ifdef TVE_TERRAIN_16
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				weightedHeights_12 = float4 ( heights_127362_g83242.x, heights_127362_g83242.y, heights_127362_g83242.z, heights_127362_g83242.w );
				weightedHeights_12 = weightedHeights_12 - maxHeight.xxxx;
				weightedHeights_12 = (max(0, weightedHeights_12 + transition) + 1e-6) * control_127362_g83242;
				weightedHeights_16 = float4 ( heights_167362_g83242.x, heights_167362_g83242.y, heights_167362_g83242.z, heights_167362_g83242.w );
				weightedHeights_16 = weightedHeights_16 - maxHeight.xxxx;
				weightedHeights_16 = (max(0, weightedHeights_16 + transition) + 1e-6) * control_167362_g83242;
				#endif
				float sumHeight_04 = weightedHeights_04.x + weightedHeights_04.y + weightedHeights_04.z + weightedHeights_04.w;
				float sumHeight_08 = weightedHeights_08.x + weightedHeights_08.y + weightedHeights_08.z + weightedHeights_08.w;
				float sumHeight_12 = weightedHeights_12.x + weightedHeights_12.y + weightedHeights_12.z + weightedHeights_12.w;
				float sumHeight_16 = weightedHeights_16.x + weightedHeights_16.y + weightedHeights_16.z + weightedHeights_16.w;
				float sumHeight = sumHeight_04 + sumHeight_08 + sumHeight_12 + sumHeight_16;
				weights_047362_g83242 = weightedHeights_04 / sumHeight.xxxx;
				#ifdef TVE_TERRAIN_08
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				#endif
				#ifdef TVE_TERRAIN_12
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				weights_127362_g83242 = weightedHeights_12 / sumHeight.xxxx;
				#endif
				#ifdef TVE_TERRAIN_16
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				weights_127362_g83242 = weightedHeights_12 / sumHeight.xxxx;
				weights_167362_g83242 = weightedHeights_16 / sumHeight.xxxx;
				#endif
				}
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8792_g83242 = weights_047362_g83242;
				#else
				float4 staticSwitch8792_g83242 = control_047362_g83242;
				#endif
				half4 Terrain_Weights_046781_g83242 = staticSwitch8792_g83242;
				half4 Weights52_g83255 = Terrain_Weights_046781_g83242;
				TEXTURE2D(Texture238_g83339) = _AlbedoTex1;
				SamplerState Sampler238_g83339 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83339 = Input_Coords_016785_g83242;
				half4 Coords238_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition238_g83339 = ase_worldPos;
				half4 localSamplePlanar2D238_g83339 = SamplePlanar2D( Texture238_g83339 , Sampler238_g83339 , Coords238_g83339 , WorldPosition238_g83339 );
				TEXTURE2D(Texture246_g83339) = _AlbedoTex1;
				SamplerState Sampler246_g83339 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition246_g83339 = ase_worldPos;
				half3 WorldNormal246_g83339 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83339 = SamplePlanar3D( Texture246_g83339 , Sampler246_g83339 , Coords246_g83339 , WorldPosition246_g83339 , WorldNormal246_g83339 );
				TEXTURE2D(Texture234_g83339) = _AlbedoTex1;
				SamplerState Sampler234_g83339 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83339 = temp_output_37_0_g83339;
				float3 WorldPosition234_g83339 = ase_worldPos;
				float4 localSampleStochastic2D234_g83339 = SampleStochastic2D( Texture234_g83339 , Sampler234_g83339 , Coords234_g83339 , WorldPosition234_g83339 );
				TEXTURE2D(Texture263_g83339) = _AlbedoTex1;
				SamplerState Sampler263_g83339 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition263_g83339 = ase_worldPos;
				half3 WorldNormal263_g83339 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83339 = SampleStochastic3D( Texture263_g83339 , Sampler263_g83339 , Coords263_g83339 , WorldPosition263_g83339 , WorldNormal263_g83339 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8614_g83242 = localSamplePlanar2D238_g83339;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8614_g83242 = localSamplePlanar3D246_g83339;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8614_g83242 = localSampleStochastic2D234_g83339;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8614_g83242 = localSampleStochastic3D263_g83339;
				#else
				float4 staticSwitch8614_g83242 = localSamplePlanar2D238_g83339;
				#endif
				half4 Layer133_g83255 = staticSwitch8614_g83242;
				TEXTURE2D(Texture238_g83292) = _AlbedoTex2;
				SamplerState Sampler238_g83292 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83292 = Input_Coords_026787_g83242;
				half4 Coords238_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition238_g83292 = ase_worldPos;
				half4 localSamplePlanar2D238_g83292 = SamplePlanar2D( Texture238_g83292 , Sampler238_g83292 , Coords238_g83292 , WorldPosition238_g83292 );
				TEXTURE2D(Texture246_g83292) = _AlbedoTex2;
				SamplerState Sampler246_g83292 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition246_g83292 = ase_worldPos;
				half3 WorldNormal246_g83292 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83292 = SamplePlanar3D( Texture246_g83292 , Sampler246_g83292 , Coords246_g83292 , WorldPosition246_g83292 , WorldNormal246_g83292 );
				TEXTURE2D(Texture234_g83292) = _AlbedoTex2;
				SamplerState Sampler234_g83292 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83292 = temp_output_37_0_g83292;
				float3 WorldPosition234_g83292 = ase_worldPos;
				float4 localSampleStochastic2D234_g83292 = SampleStochastic2D( Texture234_g83292 , Sampler234_g83292 , Coords234_g83292 , WorldPosition234_g83292 );
				TEXTURE2D(Texture263_g83292) = _AlbedoTex2;
				SamplerState Sampler263_g83292 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition263_g83292 = ase_worldPos;
				half3 WorldNormal263_g83292 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83292 = SampleStochastic3D( Texture263_g83292 , Sampler263_g83292 , Coords263_g83292 , WorldPosition263_g83292 , WorldNormal263_g83292 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8629_g83242 = localSamplePlanar2D238_g83292;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8629_g83242 = localSamplePlanar3D246_g83292;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8629_g83242 = localSampleStochastic2D234_g83292;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8629_g83242 = localSampleStochastic3D263_g83292;
				#else
				float4 staticSwitch8629_g83242 = localSamplePlanar2D238_g83292;
				#endif
				half4 Layer237_g83255 = staticSwitch8629_g83242;
				TEXTURE2D(Texture238_g83293) = _AlbedoTex3;
				SamplerState Sampler238_g83293 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83293 = Input_Coords_036789_g83242;
				half4 Coords238_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition238_g83293 = ase_worldPos;
				half4 localSamplePlanar2D238_g83293 = SamplePlanar2D( Texture238_g83293 , Sampler238_g83293 , Coords238_g83293 , WorldPosition238_g83293 );
				TEXTURE2D(Texture246_g83293) = _AlbedoTex3;
				SamplerState Sampler246_g83293 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition246_g83293 = ase_worldPos;
				half3 WorldNormal246_g83293 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83293 = SamplePlanar3D( Texture246_g83293 , Sampler246_g83293 , Coords246_g83293 , WorldPosition246_g83293 , WorldNormal246_g83293 );
				TEXTURE2D(Texture234_g83293) = _AlbedoTex3;
				SamplerState Sampler234_g83293 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83293 = temp_output_37_0_g83293;
				float3 WorldPosition234_g83293 = ase_worldPos;
				float4 localSampleStochastic2D234_g83293 = SampleStochastic2D( Texture234_g83293 , Sampler234_g83293 , Coords234_g83293 , WorldPosition234_g83293 );
				TEXTURE2D(Texture263_g83293) = _AlbedoTex3;
				SamplerState Sampler263_g83293 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition263_g83293 = ase_worldPos;
				half3 WorldNormal263_g83293 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83293 = SampleStochastic3D( Texture263_g83293 , Sampler263_g83293 , Coords263_g83293 , WorldPosition263_g83293 , WorldNormal263_g83293 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8630_g83242 = localSamplePlanar2D238_g83293;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8630_g83242 = localSamplePlanar3D246_g83293;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8630_g83242 = localSampleStochastic2D234_g83293;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8630_g83242 = localSampleStochastic3D263_g83293;
				#else
				float4 staticSwitch8630_g83242 = localSamplePlanar2D238_g83293;
				#endif
				half4 Layer338_g83255 = staticSwitch8630_g83242;
				TEXTURE2D(Texture238_g83294) = _AlbedoTex4;
				SamplerState Sampler238_g83294 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83294 = Input_Coords_046791_g83242;
				half4 Coords238_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition238_g83294 = ase_worldPos;
				half4 localSamplePlanar2D238_g83294 = SamplePlanar2D( Texture238_g83294 , Sampler238_g83294 , Coords238_g83294 , WorldPosition238_g83294 );
				TEXTURE2D(Texture246_g83294) = _AlbedoTex4;
				SamplerState Sampler246_g83294 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition246_g83294 = ase_worldPos;
				half3 WorldNormal246_g83294 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83294 = SamplePlanar3D( Texture246_g83294 , Sampler246_g83294 , Coords246_g83294 , WorldPosition246_g83294 , WorldNormal246_g83294 );
				TEXTURE2D(Texture234_g83294) = _AlbedoTex4;
				SamplerState Sampler234_g83294 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83294 = temp_output_37_0_g83294;
				float3 WorldPosition234_g83294 = ase_worldPos;
				float4 localSampleStochastic2D234_g83294 = SampleStochastic2D( Texture234_g83294 , Sampler234_g83294 , Coords234_g83294 , WorldPosition234_g83294 );
				TEXTURE2D(Texture263_g83294) = _AlbedoTex4;
				SamplerState Sampler263_g83294 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition263_g83294 = ase_worldPos;
				half3 WorldNormal263_g83294 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83294 = SampleStochastic3D( Texture263_g83294 , Sampler263_g83294 , Coords263_g83294 , WorldPosition263_g83294 , WorldNormal263_g83294 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8631_g83242 = localSamplePlanar2D238_g83294;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8631_g83242 = localSamplePlanar3D246_g83294;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8631_g83242 = localSampleStochastic2D234_g83294;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8631_g83242 = localSampleStochastic3D263_g83294;
				#else
				float4 staticSwitch8631_g83242 = localSamplePlanar2D238_g83294;
				#endif
				half4 Layer439_g83255 = staticSwitch8631_g83242;
				float4 weightedBlendVar31_g83255 = Weights52_g83255;
				float4 weightedBlend31_g83255 = ( weightedBlendVar31_g83255.x*Layer133_g83255 + weightedBlendVar31_g83255.y*Layer237_g83255 + weightedBlendVar31_g83255.z*Layer338_g83255 + weightedBlendVar31_g83255.w*Layer439_g83255 );
				half4 Terrain_Albedo_047200_g83242 = weightedBlend31_g83255;
				half4 Layer_045_g83258 = Terrain_Albedo_047200_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8793_g83242 = weights_087362_g83242;
				#else
				float4 staticSwitch8793_g83242 = control_087362_g83242;
				#endif
				half4 Terrain_Weights_087340_g83242 = staticSwitch8793_g83242;
				half4 Weights52_g83262 = Terrain_Weights_087340_g83242;
				TEXTURE2D(Texture238_g83303) = _AlbedoTex5;
				SamplerState Sampler238_g83303 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83303 = Input_Coords_058750_g83242;
				half4 Coords238_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition238_g83303 = ase_worldPos;
				half4 localSamplePlanar2D238_g83303 = SamplePlanar2D( Texture238_g83303 , Sampler238_g83303 , Coords238_g83303 , WorldPosition238_g83303 );
				TEXTURE2D(Texture246_g83303) = _AlbedoTex5;
				SamplerState Sampler246_g83303 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition246_g83303 = ase_worldPos;
				half3 WorldNormal246_g83303 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83303 = SamplePlanar3D( Texture246_g83303 , Sampler246_g83303 , Coords246_g83303 , WorldPosition246_g83303 , WorldNormal246_g83303 );
				TEXTURE2D(Texture234_g83303) = _AlbedoTex5;
				SamplerState Sampler234_g83303 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83303 = temp_output_37_0_g83303;
				float3 WorldPosition234_g83303 = ase_worldPos;
				float4 localSampleStochastic2D234_g83303 = SampleStochastic2D( Texture234_g83303 , Sampler234_g83303 , Coords234_g83303 , WorldPosition234_g83303 );
				TEXTURE2D(Texture263_g83303) = _AlbedoTex5;
				SamplerState Sampler263_g83303 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition263_g83303 = ase_worldPos;
				half3 WorldNormal263_g83303 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83303 = SampleStochastic3D( Texture263_g83303 , Sampler263_g83303 , Coords263_g83303 , WorldPosition263_g83303 , WorldNormal263_g83303 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8690_g83242 = localSamplePlanar2D238_g83303;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8690_g83242 = localSamplePlanar3D246_g83303;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8690_g83242 = localSampleStochastic2D234_g83303;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8690_g83242 = localSampleStochastic3D263_g83303;
				#else
				float4 staticSwitch8690_g83242 = localSamplePlanar2D238_g83303;
				#endif
				half4 Layer133_g83262 = staticSwitch8690_g83242;
				TEXTURE2D(Texture238_g83304) = _AlbedoTex6;
				SamplerState Sampler238_g83304 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83304 = Input_Coords_068751_g83242;
				half4 Coords238_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition238_g83304 = ase_worldPos;
				half4 localSamplePlanar2D238_g83304 = SamplePlanar2D( Texture238_g83304 , Sampler238_g83304 , Coords238_g83304 , WorldPosition238_g83304 );
				TEXTURE2D(Texture246_g83304) = _AlbedoTex6;
				SamplerState Sampler246_g83304 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition246_g83304 = ase_worldPos;
				half3 WorldNormal246_g83304 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83304 = SamplePlanar3D( Texture246_g83304 , Sampler246_g83304 , Coords246_g83304 , WorldPosition246_g83304 , WorldNormal246_g83304 );
				TEXTURE2D(Texture234_g83304) = _AlbedoTex6;
				SamplerState Sampler234_g83304 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83304 = temp_output_37_0_g83304;
				float3 WorldPosition234_g83304 = ase_worldPos;
				float4 localSampleStochastic2D234_g83304 = SampleStochastic2D( Texture234_g83304 , Sampler234_g83304 , Coords234_g83304 , WorldPosition234_g83304 );
				TEXTURE2D(Texture263_g83304) = _AlbedoTex6;
				SamplerState Sampler263_g83304 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition263_g83304 = ase_worldPos;
				half3 WorldNormal263_g83304 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83304 = SampleStochastic3D( Texture263_g83304 , Sampler263_g83304 , Coords263_g83304 , WorldPosition263_g83304 , WorldNormal263_g83304 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8691_g83242 = localSamplePlanar2D238_g83304;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8691_g83242 = localSamplePlanar3D246_g83304;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8691_g83242 = localSampleStochastic2D234_g83304;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8691_g83242 = localSampleStochastic3D263_g83304;
				#else
				float4 staticSwitch8691_g83242 = localSamplePlanar2D238_g83304;
				#endif
				half4 Layer237_g83262 = staticSwitch8691_g83242;
				TEXTURE2D(Texture238_g83305) = _AlbedoTex7;
				SamplerState Sampler238_g83305 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83305 = Input_Coords_078752_g83242;
				half4 Coords238_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition238_g83305 = ase_worldPos;
				half4 localSamplePlanar2D238_g83305 = SamplePlanar2D( Texture238_g83305 , Sampler238_g83305 , Coords238_g83305 , WorldPosition238_g83305 );
				TEXTURE2D(Texture246_g83305) = _AlbedoTex7;
				SamplerState Sampler246_g83305 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition246_g83305 = ase_worldPos;
				half3 WorldNormal246_g83305 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83305 = SamplePlanar3D( Texture246_g83305 , Sampler246_g83305 , Coords246_g83305 , WorldPosition246_g83305 , WorldNormal246_g83305 );
				TEXTURE2D(Texture234_g83305) = _AlbedoTex7;
				SamplerState Sampler234_g83305 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83305 = temp_output_37_0_g83305;
				float3 WorldPosition234_g83305 = ase_worldPos;
				float4 localSampleStochastic2D234_g83305 = SampleStochastic2D( Texture234_g83305 , Sampler234_g83305 , Coords234_g83305 , WorldPosition234_g83305 );
				TEXTURE2D(Texture263_g83305) = _AlbedoTex7;
				SamplerState Sampler263_g83305 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition263_g83305 = ase_worldPos;
				half3 WorldNormal263_g83305 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83305 = SampleStochastic3D( Texture263_g83305 , Sampler263_g83305 , Coords263_g83305 , WorldPosition263_g83305 , WorldNormal263_g83305 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8692_g83242 = localSamplePlanar2D238_g83305;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8692_g83242 = localSamplePlanar3D246_g83305;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8692_g83242 = localSampleStochastic2D234_g83305;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8692_g83242 = localSampleStochastic3D263_g83305;
				#else
				float4 staticSwitch8692_g83242 = localSamplePlanar2D238_g83305;
				#endif
				half4 Layer338_g83262 = staticSwitch8692_g83242;
				TEXTURE2D(Texture238_g83306) = _AlbedoTex8;
				SamplerState Sampler238_g83306 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83306 = Input_Coords_088749_g83242;
				half4 Coords238_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition238_g83306 = ase_worldPos;
				half4 localSamplePlanar2D238_g83306 = SamplePlanar2D( Texture238_g83306 , Sampler238_g83306 , Coords238_g83306 , WorldPosition238_g83306 );
				TEXTURE2D(Texture246_g83306) = _AlbedoTex8;
				SamplerState Sampler246_g83306 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition246_g83306 = ase_worldPos;
				half3 WorldNormal246_g83306 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83306 = SamplePlanar3D( Texture246_g83306 , Sampler246_g83306 , Coords246_g83306 , WorldPosition246_g83306 , WorldNormal246_g83306 );
				TEXTURE2D(Texture234_g83306) = _AlbedoTex8;
				SamplerState Sampler234_g83306 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83306 = temp_output_37_0_g83306;
				float3 WorldPosition234_g83306 = ase_worldPos;
				float4 localSampleStochastic2D234_g83306 = SampleStochastic2D( Texture234_g83306 , Sampler234_g83306 , Coords234_g83306 , WorldPosition234_g83306 );
				TEXTURE2D(Texture263_g83306) = _AlbedoTex8;
				SamplerState Sampler263_g83306 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition263_g83306 = ase_worldPos;
				half3 WorldNormal263_g83306 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83306 = SampleStochastic3D( Texture263_g83306 , Sampler263_g83306 , Coords263_g83306 , WorldPosition263_g83306 , WorldNormal263_g83306 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8693_g83242 = localSamplePlanar2D238_g83306;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8693_g83242 = localSamplePlanar3D246_g83306;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8693_g83242 = localSampleStochastic2D234_g83306;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8693_g83242 = localSampleStochastic3D263_g83306;
				#else
				float4 staticSwitch8693_g83242 = localSamplePlanar2D238_g83306;
				#endif
				half4 Layer439_g83262 = staticSwitch8693_g83242;
				float4 weightedBlendVar31_g83262 = Weights52_g83262;
				float4 weightedBlend31_g83262 = ( weightedBlendVar31_g83262.x*Layer133_g83262 + weightedBlendVar31_g83262.y*Layer237_g83262 + weightedBlendVar31_g83262.z*Layer338_g83262 + weightedBlendVar31_g83262.w*Layer439_g83262 );
				half4 Terrain_Albedo_088665_g83242 = weightedBlend31_g83262;
				half4 Layer_0810_g83258 = Terrain_Albedo_088665_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8794_g83242 = weights_127362_g83242;
				#else
				float4 staticSwitch8794_g83242 = control_127362_g83242;
				#endif
				half4 Terrain_Weights_127710_g83242 = staticSwitch8794_g83242;
				half4 Weights52_g83272 = Terrain_Weights_127710_g83242;
				TEXTURE2D(Texture238_g83315) = _AlbedoTex9;
				SamplerState Sampler238_g83315 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83315 = Input_Coords_098833_g83242;
				half4 Coords238_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition238_g83315 = ase_worldPos;
				half4 localSamplePlanar2D238_g83315 = SamplePlanar2D( Texture238_g83315 , Sampler238_g83315 , Coords238_g83315 , WorldPosition238_g83315 );
				TEXTURE2D(Texture246_g83315) = _AlbedoTex9;
				SamplerState Sampler246_g83315 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition246_g83315 = ase_worldPos;
				half3 WorldNormal246_g83315 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83315 = SamplePlanar3D( Texture246_g83315 , Sampler246_g83315 , Coords246_g83315 , WorldPosition246_g83315 , WorldNormal246_g83315 );
				TEXTURE2D(Texture234_g83315) = _AlbedoTex9;
				SamplerState Sampler234_g83315 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83315 = temp_output_37_0_g83315;
				float3 WorldPosition234_g83315 = ase_worldPos;
				float4 localSampleStochastic2D234_g83315 = SampleStochastic2D( Texture234_g83315 , Sampler234_g83315 , Coords234_g83315 , WorldPosition234_g83315 );
				TEXTURE2D(Texture263_g83315) = _AlbedoTex9;
				SamplerState Sampler263_g83315 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition263_g83315 = ase_worldPos;
				half3 WorldNormal263_g83315 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83315 = SampleStochastic3D( Texture263_g83315 , Sampler263_g83315 , Coords263_g83315 , WorldPosition263_g83315 , WorldNormal263_g83315 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8872_g83242 = localSamplePlanar2D238_g83315;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8872_g83242 = localSamplePlanar3D246_g83315;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8872_g83242 = localSampleStochastic2D234_g83315;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8872_g83242 = localSampleStochastic3D263_g83315;
				#else
				float4 staticSwitch8872_g83242 = localSamplePlanar2D238_g83315;
				#endif
				half4 Layer133_g83272 = staticSwitch8872_g83242;
				TEXTURE2D(Texture238_g83316) = _AlbedoTex10;
				SamplerState Sampler238_g83316 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83316 = Input_Coords_108834_g83242;
				half4 Coords238_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition238_g83316 = ase_worldPos;
				half4 localSamplePlanar2D238_g83316 = SamplePlanar2D( Texture238_g83316 , Sampler238_g83316 , Coords238_g83316 , WorldPosition238_g83316 );
				TEXTURE2D(Texture246_g83316) = _AlbedoTex10;
				SamplerState Sampler246_g83316 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition246_g83316 = ase_worldPos;
				half3 WorldNormal246_g83316 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83316 = SamplePlanar3D( Texture246_g83316 , Sampler246_g83316 , Coords246_g83316 , WorldPosition246_g83316 , WorldNormal246_g83316 );
				TEXTURE2D(Texture234_g83316) = _AlbedoTex10;
				SamplerState Sampler234_g83316 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83316 = temp_output_37_0_g83316;
				float3 WorldPosition234_g83316 = ase_worldPos;
				float4 localSampleStochastic2D234_g83316 = SampleStochastic2D( Texture234_g83316 , Sampler234_g83316 , Coords234_g83316 , WorldPosition234_g83316 );
				TEXTURE2D(Texture263_g83316) = _AlbedoTex10;
				SamplerState Sampler263_g83316 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition263_g83316 = ase_worldPos;
				half3 WorldNormal263_g83316 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83316 = SampleStochastic3D( Texture263_g83316 , Sampler263_g83316 , Coords263_g83316 , WorldPosition263_g83316 , WorldNormal263_g83316 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8873_g83242 = localSamplePlanar2D238_g83316;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8873_g83242 = localSamplePlanar3D246_g83316;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8873_g83242 = localSampleStochastic2D234_g83316;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8873_g83242 = localSampleStochastic3D263_g83316;
				#else
				float4 staticSwitch8873_g83242 = localSamplePlanar2D238_g83316;
				#endif
				half4 Layer237_g83272 = staticSwitch8873_g83242;
				TEXTURE2D(Texture238_g83317) = _AlbedoTex11;
				SamplerState Sampler238_g83317 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83317 = Input_Coords_118835_g83242;
				half4 Coords238_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition238_g83317 = ase_worldPos;
				half4 localSamplePlanar2D238_g83317 = SamplePlanar2D( Texture238_g83317 , Sampler238_g83317 , Coords238_g83317 , WorldPosition238_g83317 );
				TEXTURE2D(Texture246_g83317) = _AlbedoTex11;
				SamplerState Sampler246_g83317 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition246_g83317 = ase_worldPos;
				half3 WorldNormal246_g83317 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83317 = SamplePlanar3D( Texture246_g83317 , Sampler246_g83317 , Coords246_g83317 , WorldPosition246_g83317 , WorldNormal246_g83317 );
				TEXTURE2D(Texture234_g83317) = _AlbedoTex11;
				SamplerState Sampler234_g83317 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83317 = temp_output_37_0_g83317;
				float3 WorldPosition234_g83317 = ase_worldPos;
				float4 localSampleStochastic2D234_g83317 = SampleStochastic2D( Texture234_g83317 , Sampler234_g83317 , Coords234_g83317 , WorldPosition234_g83317 );
				TEXTURE2D(Texture263_g83317) = _AlbedoTex11;
				SamplerState Sampler263_g83317 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition263_g83317 = ase_worldPos;
				half3 WorldNormal263_g83317 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83317 = SampleStochastic3D( Texture263_g83317 , Sampler263_g83317 , Coords263_g83317 , WorldPosition263_g83317 , WorldNormal263_g83317 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8874_g83242 = localSamplePlanar2D238_g83317;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8874_g83242 = localSamplePlanar3D246_g83317;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8874_g83242 = localSampleStochastic2D234_g83317;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8874_g83242 = localSampleStochastic3D263_g83317;
				#else
				float4 staticSwitch8874_g83242 = localSamplePlanar2D238_g83317;
				#endif
				half4 Layer338_g83272 = staticSwitch8874_g83242;
				TEXTURE2D(Texture238_g83318) = _AlbedoTex12;
				SamplerState Sampler238_g83318 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83318 = Input_Coords_128836_g83242;
				half4 Coords238_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition238_g83318 = ase_worldPos;
				half4 localSamplePlanar2D238_g83318 = SamplePlanar2D( Texture238_g83318 , Sampler238_g83318 , Coords238_g83318 , WorldPosition238_g83318 );
				TEXTURE2D(Texture246_g83318) = _AlbedoTex12;
				SamplerState Sampler246_g83318 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition246_g83318 = ase_worldPos;
				half3 WorldNormal246_g83318 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83318 = SamplePlanar3D( Texture246_g83318 , Sampler246_g83318 , Coords246_g83318 , WorldPosition246_g83318 , WorldNormal246_g83318 );
				TEXTURE2D(Texture234_g83318) = _AlbedoTex12;
				SamplerState Sampler234_g83318 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83318 = temp_output_37_0_g83318;
				float3 WorldPosition234_g83318 = ase_worldPos;
				float4 localSampleStochastic2D234_g83318 = SampleStochastic2D( Texture234_g83318 , Sampler234_g83318 , Coords234_g83318 , WorldPosition234_g83318 );
				TEXTURE2D(Texture263_g83318) = _AlbedoTex12;
				SamplerState Sampler263_g83318 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition263_g83318 = ase_worldPos;
				half3 WorldNormal263_g83318 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83318 = SampleStochastic3D( Texture263_g83318 , Sampler263_g83318 , Coords263_g83318 , WorldPosition263_g83318 , WorldNormal263_g83318 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8875_g83242 = localSamplePlanar2D238_g83318;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8875_g83242 = localSamplePlanar3D246_g83318;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8875_g83242 = localSampleStochastic2D234_g83318;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8875_g83242 = localSampleStochastic3D263_g83318;
				#else
				float4 staticSwitch8875_g83242 = localSamplePlanar2D238_g83318;
				#endif
				half4 Layer439_g83272 = staticSwitch8875_g83242;
				float4 weightedBlendVar31_g83272 = Weights52_g83272;
				float4 weightedBlend31_g83272 = ( weightedBlendVar31_g83272.x*Layer133_g83272 + weightedBlendVar31_g83272.y*Layer237_g83272 + weightedBlendVar31_g83272.z*Layer338_g83272 + weightedBlendVar31_g83272.w*Layer439_g83272 );
				half4 Terrain_Albedo_128851_g83242 = weightedBlend31_g83272;
				half4 Layer_1243_g83258 = Terrain_Albedo_128851_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8795_g83242 = weights_167362_g83242;
				#else
				float4 staticSwitch8795_g83242 = control_167362_g83242;
				#endif
				half4 Terrain_Weights_167709_g83242 = staticSwitch8795_g83242;
				half4 Weights52_g83282 = Terrain_Weights_167709_g83242;
				TEXTURE2D(Texture238_g83327) = _AlbedoTex13;
				SamplerState Sampler238_g83327 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83327 = Input_Coords_138960_g83242;
				half4 Coords238_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition238_g83327 = ase_worldPos;
				half4 localSamplePlanar2D238_g83327 = SamplePlanar2D( Texture238_g83327 , Sampler238_g83327 , Coords238_g83327 , WorldPosition238_g83327 );
				TEXTURE2D(Texture246_g83327) = _AlbedoTex13;
				SamplerState Sampler246_g83327 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition246_g83327 = ase_worldPos;
				half3 WorldNormal246_g83327 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83327 = SamplePlanar3D( Texture246_g83327 , Sampler246_g83327 , Coords246_g83327 , WorldPosition246_g83327 , WorldNormal246_g83327 );
				TEXTURE2D(Texture234_g83327) = _AlbedoTex13;
				SamplerState Sampler234_g83327 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83327 = temp_output_37_0_g83327;
				float3 WorldPosition234_g83327 = ase_worldPos;
				float4 localSampleStochastic2D234_g83327 = SampleStochastic2D( Texture234_g83327 , Sampler234_g83327 , Coords234_g83327 , WorldPosition234_g83327 );
				TEXTURE2D(Texture263_g83327) = _AlbedoTex13;
				SamplerState Sampler263_g83327 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition263_g83327 = ase_worldPos;
				half3 WorldNormal263_g83327 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83327 = SampleStochastic3D( Texture263_g83327 , Sampler263_g83327 , Coords263_g83327 , WorldPosition263_g83327 , WorldNormal263_g83327 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch8972_g83242 = localSamplePlanar2D238_g83327;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch8972_g83242 = localSamplePlanar3D246_g83327;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch8972_g83242 = localSampleStochastic2D234_g83327;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch8972_g83242 = localSampleStochastic3D263_g83327;
				#else
				float4 staticSwitch8972_g83242 = localSamplePlanar2D238_g83327;
				#endif
				half4 Layer133_g83282 = staticSwitch8972_g83242;
				TEXTURE2D(Texture238_g83328) = _AlbedoTex14;
				SamplerState Sampler238_g83328 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83328 = Input_Coords_148961_g83242;
				half4 Coords238_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition238_g83328 = ase_worldPos;
				half4 localSamplePlanar2D238_g83328 = SamplePlanar2D( Texture238_g83328 , Sampler238_g83328 , Coords238_g83328 , WorldPosition238_g83328 );
				TEXTURE2D(Texture246_g83328) = _AlbedoTex14;
				SamplerState Sampler246_g83328 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition246_g83328 = ase_worldPos;
				half3 WorldNormal246_g83328 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83328 = SamplePlanar3D( Texture246_g83328 , Sampler246_g83328 , Coords246_g83328 , WorldPosition246_g83328 , WorldNormal246_g83328 );
				TEXTURE2D(Texture234_g83328) = _AlbedoTex14;
				SamplerState Sampler234_g83328 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83328 = temp_output_37_0_g83328;
				float3 WorldPosition234_g83328 = ase_worldPos;
				float4 localSampleStochastic2D234_g83328 = SampleStochastic2D( Texture234_g83328 , Sampler234_g83328 , Coords234_g83328 , WorldPosition234_g83328 );
				TEXTURE2D(Texture263_g83328) = _AlbedoTex14;
				SamplerState Sampler263_g83328 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition263_g83328 = ase_worldPos;
				half3 WorldNormal263_g83328 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83328 = SampleStochastic3D( Texture263_g83328 , Sampler263_g83328 , Coords263_g83328 , WorldPosition263_g83328 , WorldNormal263_g83328 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch8973_g83242 = localSamplePlanar2D238_g83328;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch8973_g83242 = localSamplePlanar3D246_g83328;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch8973_g83242 = localSampleStochastic2D234_g83328;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch8973_g83242 = localSampleStochastic3D263_g83328;
				#else
				float4 staticSwitch8973_g83242 = localSamplePlanar2D238_g83328;
				#endif
				half4 Layer237_g83282 = staticSwitch8973_g83242;
				TEXTURE2D(Texture238_g83329) = _AlbedoTex15;
				SamplerState Sampler238_g83329 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83329 = Input_Coords_158962_g83242;
				half4 Coords238_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition238_g83329 = ase_worldPos;
				half4 localSamplePlanar2D238_g83329 = SamplePlanar2D( Texture238_g83329 , Sampler238_g83329 , Coords238_g83329 , WorldPosition238_g83329 );
				TEXTURE2D(Texture246_g83329) = _AlbedoTex15;
				SamplerState Sampler246_g83329 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition246_g83329 = ase_worldPos;
				half3 WorldNormal246_g83329 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83329 = SamplePlanar3D( Texture246_g83329 , Sampler246_g83329 , Coords246_g83329 , WorldPosition246_g83329 , WorldNormal246_g83329 );
				TEXTURE2D(Texture234_g83329) = _AlbedoTex15;
				SamplerState Sampler234_g83329 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83329 = temp_output_37_0_g83329;
				float3 WorldPosition234_g83329 = ase_worldPos;
				float4 localSampleStochastic2D234_g83329 = SampleStochastic2D( Texture234_g83329 , Sampler234_g83329 , Coords234_g83329 , WorldPosition234_g83329 );
				TEXTURE2D(Texture263_g83329) = _AlbedoTex15;
				SamplerState Sampler263_g83329 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition263_g83329 = ase_worldPos;
				half3 WorldNormal263_g83329 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83329 = SampleStochastic3D( Texture263_g83329 , Sampler263_g83329 , Coords263_g83329 , WorldPosition263_g83329 , WorldNormal263_g83329 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch8974_g83242 = localSamplePlanar2D238_g83329;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch8974_g83242 = localSamplePlanar3D246_g83329;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch8974_g83242 = localSampleStochastic2D234_g83329;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch8974_g83242 = localSampleStochastic3D263_g83329;
				#else
				float4 staticSwitch8974_g83242 = localSamplePlanar2D238_g83329;
				#endif
				half4 Layer338_g83282 = staticSwitch8974_g83242;
				TEXTURE2D(Texture238_g83330) = _AlbedoTex16;
				SamplerState Sampler238_g83330 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83330 = Input_Coords_168959_g83242;
				half4 Coords238_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition238_g83330 = ase_worldPos;
				half4 localSamplePlanar2D238_g83330 = SamplePlanar2D( Texture238_g83330 , Sampler238_g83330 , Coords238_g83330 , WorldPosition238_g83330 );
				TEXTURE2D(Texture246_g83330) = _AlbedoTex16;
				SamplerState Sampler246_g83330 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition246_g83330 = ase_worldPos;
				half3 WorldNormal246_g83330 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83330 = SamplePlanar3D( Texture246_g83330 , Sampler246_g83330 , Coords246_g83330 , WorldPosition246_g83330 , WorldNormal246_g83330 );
				TEXTURE2D(Texture234_g83330) = _AlbedoTex16;
				SamplerState Sampler234_g83330 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83330 = temp_output_37_0_g83330;
				float3 WorldPosition234_g83330 = ase_worldPos;
				float4 localSampleStochastic2D234_g83330 = SampleStochastic2D( Texture234_g83330 , Sampler234_g83330 , Coords234_g83330 , WorldPosition234_g83330 );
				TEXTURE2D(Texture263_g83330) = _AlbedoTex16;
				SamplerState Sampler263_g83330 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition263_g83330 = ase_worldPos;
				half3 WorldNormal263_g83330 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83330 = SampleStochastic3D( Texture263_g83330 , Sampler263_g83330 , Coords263_g83330 , WorldPosition263_g83330 , WorldNormal263_g83330 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch8975_g83242 = localSamplePlanar2D238_g83330;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch8975_g83242 = localSamplePlanar3D246_g83330;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch8975_g83242 = localSampleStochastic2D234_g83330;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch8975_g83242 = localSampleStochastic3D263_g83330;
				#else
				float4 staticSwitch8975_g83242 = localSamplePlanar2D238_g83330;
				#endif
				half4 Layer439_g83282 = staticSwitch8975_g83242;
				float4 weightedBlendVar31_g83282 = Weights52_g83282;
				float4 weightedBlend31_g83282 = ( weightedBlendVar31_g83282.x*Layer133_g83282 + weightedBlendVar31_g83282.y*Layer237_g83282 + weightedBlendVar31_g83282.z*Layer338_g83282 + weightedBlendVar31_g83282.w*Layer439_g83282 );
				half4 Terrain_Albedo_168986_g83242 = weightedBlend31_g83282;
				half4 Layer_1644_g83258 = Terrain_Albedo_168986_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83258 = Layer_045_g83258;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 + Layer_1243_g83258 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 + Layer_1243_g83258 + Layer_1644_g83258 );
				#else
				float4 staticSwitch40_g83258 = Layer_045_g83258;
				#endif
				half4 Blend_Albedo7468_g83242 = staticSwitch40_g83258;
				half4 Terrain_Albedo6800_g79798 = Blend_Albedo7468_g83242;
				half3 Blend_Albedo2808_g79798 = ( (Terrain_Albedo6800_g79798).xyz * (_TerrainColor).rgb );
				half3 Blend_Albedo_Tinted7319_g79798 = Blend_Albedo2808_g79798;
				float3 temp_output_3_0_g79843 = Blend_Albedo2808_g79798;
				float dotResult20_g79843 = dot( temp_output_3_0_g79843 , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Grayscale5939_g79798 = dotResult20_g79843;
				float3 temp_cast_8 = (Blend_Albedo_Grayscale5939_g79798).xxx;
				float temp_output_82_0_g79821 = _LayerColorsValue;
				float temp_output_19_0_g79825 = TVE_ColorsUsage[(int)temp_output_82_0_g79821];
				float4 temp_output_91_19_g79821 = TVE_ColorsCoords;
				float3 vertexToFrag7344_g79798 = packedInput.ase_texcoord5.xyz;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV94_g79821 = ( (temp_output_91_19_g79821).zw + ( (temp_output_91_19_g79821).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode83_g79821 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, UV94_g79821,temp_output_82_0_g79821, 0.0 );
				float4 temp_output_17_0_g79825 = tex2DArrayNode83_g79821;
				float4 temp_output_92_86_g79821 = TVE_ColorsParams;
				float4 temp_output_3_0_g79825 = temp_output_92_86_g79821;
				float4 ifLocalVar18_g79825 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79825 >= 0.5 )
				ifLocalVar18_g79825 = temp_output_17_0_g79825;
				else
				ifLocalVar18_g79825 = temp_output_3_0_g79825;
				float4 lerpResult22_g79825 = lerp( temp_output_3_0_g79825 , temp_output_17_0_g79825 , temp_output_19_0_g79825);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79825 = lerpResult22_g79825;
				#else
				float4 staticSwitch24_g79825 = ifLocalVar18_g79825;
				#endif
				half4 Global_Colors_Params5434_g79798 = staticSwitch24_g79825;
				float4 temp_output_346_0_g79804 = Global_Colors_Params5434_g79798;
				half Global_Colors_A1701_g79798 = saturate( (temp_output_346_0_g79804).w );
				half Colors_Influence3668_g79798 = Global_Colors_A1701_g79798;
				float temp_output_6306_0_g79798 = ( 1.0 - Colors_Influence3668_g79798 );
				float3 lerpResult3618_g79798 = lerp( Blend_Albedo_Tinted7319_g79798 , temp_cast_8 , ( 1.0 - ( temp_output_6306_0_g79798 * temp_output_6306_0_g79798 ) ));
				half3 Global_Colors_RGB1700_g79798 = (temp_output_346_0_g79804).xyz;
				half3 Colors_RGB1954_g79798 = ( Global_Colors_RGB1700_g79798 * 4.594794 * _ColorsIntensityValue );
				half4 Weights52_g83254 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83254 = _Specular1;
				half4 Layer237_g83254 = _Specular2;
				half4 Layer338_g83254 = _Specular3;
				half4 Layer439_g83254 = _Specular4;
				float4 weightedBlendVar31_g83254 = Weights52_g83254;
				float4 weightedBlend31_g83254 = ( weightedBlendVar31_g83254.x*Layer133_g83254 + weightedBlendVar31_g83254.y*Layer237_g83254 + weightedBlendVar31_g83254.z*Layer338_g83254 + weightedBlendVar31_g83254.w*Layer439_g83254 );
				half4 Terrain_Specular_047390_g83242 = weightedBlend31_g83254;
				half4 Layer_045_g83261 = Terrain_Specular_047390_g83242;
				half4 Weights52_g83271 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83271 = _Specular5;
				half4 Layer237_g83271 = _Specular6;
				half4 Layer338_g83271 = _Specular7;
				half4 Layer439_g83271 = _Specular8;
				float4 weightedBlendVar31_g83271 = Weights52_g83271;
				float4 weightedBlend31_g83271 = ( weightedBlendVar31_g83271.x*Layer133_g83271 + weightedBlendVar31_g83271.y*Layer237_g83271 + weightedBlendVar31_g83271.z*Layer338_g83271 + weightedBlendVar31_g83271.w*Layer439_g83271 );
				half4 Terrain_Specular_088745_g83242 = weightedBlend31_g83271;
				half4 Layer_0810_g83261 = Terrain_Specular_088745_g83242;
				half4 Weights52_g83281 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83281 = _Specular9;
				half4 Layer237_g83281 = _Specular10;
				half4 Layer338_g83281 = _Specular11;
				half4 Layer439_g83281 = _Specular12;
				float4 weightedBlendVar31_g83281 = Weights52_g83281;
				float4 weightedBlend31_g83281 = ( weightedBlendVar31_g83281.x*Layer133_g83281 + weightedBlendVar31_g83281.y*Layer237_g83281 + weightedBlendVar31_g83281.z*Layer338_g83281 + weightedBlendVar31_g83281.w*Layer439_g83281 );
				half4 Terrain_Specular_128869_g83242 = weightedBlend31_g83281;
				half4 Layer_1243_g83261 = Terrain_Specular_128869_g83242;
				half4 Weights52_g83291 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83291 = _Specular13;
				half4 Layer237_g83291 = _Specular14;
				half4 Layer338_g83291 = _Specular15;
				half4 Layer439_g83291 = _Specular16;
				float4 weightedBlendVar31_g83291 = Weights52_g83291;
				float4 weightedBlend31_g83291 = ( weightedBlendVar31_g83291.x*Layer133_g83291 + weightedBlendVar31_g83291.y*Layer237_g83291 + weightedBlendVar31_g83291.z*Layer338_g83291 + weightedBlendVar31_g83291.w*Layer439_g83291 );
				half4 Terrain_Specular_169019_g83242 = weightedBlend31_g83291;
				half4 Layer_1644_g83261 = Terrain_Specular_169019_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83261 = Layer_045_g83261;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 + Layer_1243_g83261 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 + Layer_1243_g83261 + Layer_1644_g83261 );
				#else
				float4 staticSwitch40_g83261 = Layer_045_g83261;
				#endif
				half4 Blend_Specular7446_g83242 = staticSwitch40_g83261;
				half4 Terrain_Specular7322_g79798 = Blend_Specular7446_g83242;
				half Colors_Value3692_g79798 = ( (Terrain_Albedo6800_g79798).w * _GlobalColors * (Terrain_Specular7322_g79798).a );
				float clampResult6740_g79798 = clamp( saturate( ( Blend_Albedo_Grayscale5939_g79798 * 5.0 ) ) , 0.2 , 1.0 );
				half Blend_Albedo_Globals6410_g79798 = clampResult6740_g79798;
				float temp_output_7_0_g79846 = 0.1;
				float temp_output_10_0_g79846 = ( 0.2 - temp_output_7_0_g79846 );
				float lerpResult16_g79845 = lerp( 0.0 , saturate( ( ( ( Colors_Value3692_g79798 * Colors_Influence3668_g79798 * Blend_Albedo_Globals6410_g79798 ) - temp_output_7_0_g79846 ) / ( temp_output_10_0_g79846 + 0.0001 ) ) ) , TVE_IsEnabled);
				float3 lerpResult3628_g79798 = lerp( Blend_Albedo_Tinted7319_g79798 , ( lerpResult3618_g79798 * Colors_RGB1954_g79798 ) , lerpResult16_g79845);
				half3 Blend_Albedo_Colored_High6027_g79798 = lerpResult3628_g79798;
				half3 Blend_Albedo_Colored863_g79798 = Blend_Albedo_Colored_High6027_g79798;
				half3 Global_OverlayColor1758_g79798 = (TVE_OverlayColor).rgb;
				float temp_output_84_0_g79816 = _LayerExtrasValue;
				float temp_output_19_0_g79820 = TVE_ExtrasUsage[(int)temp_output_84_0_g79816];
				float4 temp_output_93_19_g79816 = TVE_ExtrasCoords;
				half2 UV96_g79816 = ( (temp_output_93_19_g79816).zw + ( (temp_output_93_19_g79816).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode48_g79816 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g79816,temp_output_84_0_g79816, 0.0 );
				float4 temp_output_17_0_g79820 = tex2DArrayNode48_g79816;
				float4 temp_output_94_85_g79816 = TVE_ExtrasParams;
				float4 temp_output_3_0_g79820 = temp_output_94_85_g79816;
				float4 ifLocalVar18_g79820 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79820 >= 0.5 )
				ifLocalVar18_g79820 = temp_output_17_0_g79820;
				else
				ifLocalVar18_g79820 = temp_output_3_0_g79820;
				float4 lerpResult22_g79820 = lerp( temp_output_3_0_g79820 , temp_output_17_0_g79820 , temp_output_19_0_g79820);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79820 = lerpResult22_g79820;
				#else
				float4 staticSwitch24_g79820 = ifLocalVar18_g79820;
				#endif
				half4 Global_Extras_Params5440_g79798 = staticSwitch24_g79820;
				float4 break456_g79805 = Global_Extras_Params5440_g79798;
				half Global_Extras_Overlay156_g79798 = break456_g79805.z;
				half Overlay_Value5738_g79798 = ( _GlobalOverlay * Global_Extras_Overlay156_g79798 );
				float3 ase_worldTangent = packedInput.ase_texcoord6.xyz;
				float3 ase_worldBitangent = packedInput.ase_texcoord7.xyz;
				float3x3 ase_worldToTangent = float3x3(ase_worldTangent,ase_worldBitangent,ase_worldNormal);
				half4 Weights52_g83247 = Terrain_Weights_046781_g83242;
				TEXTURE2D(Texture238_g83295) = _NormalTex1;
				SamplerState Sampler238_g83295 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83295 = Input_Coords_016785_g83242;
				half4 Coords238_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition238_g83295 = ase_worldPos;
				half4 localSamplePlanar2D238_g83295 = SamplePlanar2D( Texture238_g83295 , Sampler238_g83295 , Coords238_g83295 , WorldPosition238_g83295 );
				TEXTURE2D(Texture246_g83295) = _NormalTex1;
				SamplerState Sampler246_g83295 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition246_g83295 = ase_worldPos;
				half3 WorldNormal246_g83295 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83295 = SamplePlanar3D( Texture246_g83295 , Sampler246_g83295 , Coords246_g83295 , WorldPosition246_g83295 , WorldNormal246_g83295 );
				TEXTURE2D(Texture234_g83295) = _NormalTex1;
				SamplerState Sampler234_g83295 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83295 = temp_output_37_0_g83295;
				float3 WorldPosition234_g83295 = ase_worldPos;
				float4 localSampleStochastic2D234_g83295 = SampleStochastic2D( Texture234_g83295 , Sampler234_g83295 , Coords234_g83295 , WorldPosition234_g83295 );
				TEXTURE2D(Texture263_g83295) = _NormalTex1;
				SamplerState Sampler263_g83295 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition263_g83295 = ase_worldPos;
				half3 WorldNormal263_g83295 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83295 = SampleStochastic3D( Texture263_g83295 , Sampler263_g83295 , Coords263_g83295 , WorldPosition263_g83295 , WorldNormal263_g83295 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8635_g83242 = localSamplePlanar2D238_g83295;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8635_g83242 = localSamplePlanar3D246_g83295;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8635_g83242 = localSampleStochastic2D234_g83295;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8635_g83242 = localSampleStochastic3D263_g83295;
				#else
				float4 staticSwitch8635_g83242 = localSamplePlanar2D238_g83295;
				#endif
				half4 Layer133_g83247 = staticSwitch8635_g83242;
				TEXTURE2D(Texture238_g83296) = _NormalTex2;
				SamplerState Sampler238_g83296 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83296 = Input_Coords_026787_g83242;
				half4 Coords238_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition238_g83296 = ase_worldPos;
				half4 localSamplePlanar2D238_g83296 = SamplePlanar2D( Texture238_g83296 , Sampler238_g83296 , Coords238_g83296 , WorldPosition238_g83296 );
				TEXTURE2D(Texture246_g83296) = _NormalTex2;
				SamplerState Sampler246_g83296 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition246_g83296 = ase_worldPos;
				half3 WorldNormal246_g83296 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83296 = SamplePlanar3D( Texture246_g83296 , Sampler246_g83296 , Coords246_g83296 , WorldPosition246_g83296 , WorldNormal246_g83296 );
				TEXTURE2D(Texture234_g83296) = _NormalTex2;
				SamplerState Sampler234_g83296 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83296 = temp_output_37_0_g83296;
				float3 WorldPosition234_g83296 = ase_worldPos;
				float4 localSampleStochastic2D234_g83296 = SampleStochastic2D( Texture234_g83296 , Sampler234_g83296 , Coords234_g83296 , WorldPosition234_g83296 );
				TEXTURE2D(Texture263_g83296) = _NormalTex2;
				SamplerState Sampler263_g83296 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition263_g83296 = ase_worldPos;
				half3 WorldNormal263_g83296 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83296 = SampleStochastic3D( Texture263_g83296 , Sampler263_g83296 , Coords263_g83296 , WorldPosition263_g83296 , WorldNormal263_g83296 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8636_g83242 = localSamplePlanar2D238_g83296;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8636_g83242 = localSamplePlanar3D246_g83296;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8636_g83242 = localSampleStochastic2D234_g83296;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8636_g83242 = localSampleStochastic3D263_g83296;
				#else
				float4 staticSwitch8636_g83242 = localSamplePlanar2D238_g83296;
				#endif
				half4 Layer237_g83247 = staticSwitch8636_g83242;
				TEXTURE2D(Texture238_g83297) = _NormalTex3;
				SamplerState Sampler238_g83297 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83297 = Input_Coords_036789_g83242;
				half4 Coords238_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition238_g83297 = ase_worldPos;
				half4 localSamplePlanar2D238_g83297 = SamplePlanar2D( Texture238_g83297 , Sampler238_g83297 , Coords238_g83297 , WorldPosition238_g83297 );
				TEXTURE2D(Texture246_g83297) = _NormalTex3;
				SamplerState Sampler246_g83297 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition246_g83297 = ase_worldPos;
				half3 WorldNormal246_g83297 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83297 = SamplePlanar3D( Texture246_g83297 , Sampler246_g83297 , Coords246_g83297 , WorldPosition246_g83297 , WorldNormal246_g83297 );
				TEXTURE2D(Texture234_g83297) = _NormalTex3;
				SamplerState Sampler234_g83297 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83297 = temp_output_37_0_g83297;
				float3 WorldPosition234_g83297 = ase_worldPos;
				float4 localSampleStochastic2D234_g83297 = SampleStochastic2D( Texture234_g83297 , Sampler234_g83297 , Coords234_g83297 , WorldPosition234_g83297 );
				TEXTURE2D(Texture263_g83297) = _NormalTex3;
				SamplerState Sampler263_g83297 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition263_g83297 = ase_worldPos;
				half3 WorldNormal263_g83297 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83297 = SampleStochastic3D( Texture263_g83297 , Sampler263_g83297 , Coords263_g83297 , WorldPosition263_g83297 , WorldNormal263_g83297 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8637_g83242 = localSamplePlanar2D238_g83297;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8637_g83242 = localSamplePlanar3D246_g83297;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8637_g83242 = localSampleStochastic2D234_g83297;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8637_g83242 = localSampleStochastic3D263_g83297;
				#else
				float4 staticSwitch8637_g83242 = localSamplePlanar2D238_g83297;
				#endif
				half4 Layer338_g83247 = staticSwitch8637_g83242;
				TEXTURE2D(Texture238_g83298) = _NormalTex4;
				SamplerState Sampler238_g83298 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83298 = Input_Coords_046791_g83242;
				half4 Coords238_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition238_g83298 = ase_worldPos;
				half4 localSamplePlanar2D238_g83298 = SamplePlanar2D( Texture238_g83298 , Sampler238_g83298 , Coords238_g83298 , WorldPosition238_g83298 );
				TEXTURE2D(Texture246_g83298) = _NormalTex4;
				SamplerState Sampler246_g83298 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition246_g83298 = ase_worldPos;
				half3 WorldNormal246_g83298 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83298 = SamplePlanar3D( Texture246_g83298 , Sampler246_g83298 , Coords246_g83298 , WorldPosition246_g83298 , WorldNormal246_g83298 );
				TEXTURE2D(Texture234_g83298) = _NormalTex4;
				SamplerState Sampler234_g83298 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83298 = temp_output_37_0_g83298;
				float3 WorldPosition234_g83298 = ase_worldPos;
				float4 localSampleStochastic2D234_g83298 = SampleStochastic2D( Texture234_g83298 , Sampler234_g83298 , Coords234_g83298 , WorldPosition234_g83298 );
				TEXTURE2D(Texture263_g83298) = _NormalTex4;
				SamplerState Sampler263_g83298 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition263_g83298 = ase_worldPos;
				half3 WorldNormal263_g83298 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83298 = SampleStochastic3D( Texture263_g83298 , Sampler263_g83298 , Coords263_g83298 , WorldPosition263_g83298 , WorldNormal263_g83298 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8638_g83242 = localSamplePlanar2D238_g83298;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8638_g83242 = localSamplePlanar3D246_g83298;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8638_g83242 = localSampleStochastic2D234_g83298;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8638_g83242 = localSampleStochastic3D263_g83298;
				#else
				float4 staticSwitch8638_g83242 = localSamplePlanar2D238_g83298;
				#endif
				half4 Layer439_g83247 = staticSwitch8638_g83242;
				float4 weightedBlendVar31_g83247 = Weights52_g83247;
				float4 weightedBlend31_g83247 = ( weightedBlendVar31_g83247.x*Layer133_g83247 + weightedBlendVar31_g83247.y*Layer237_g83247 + weightedBlendVar31_g83247.z*Layer338_g83247 + weightedBlendVar31_g83247.w*Layer439_g83247 );
				half4 Terrain_Normal_047202_g83242 = weightedBlend31_g83247;
				half4 Layer_045_g83257 = Terrain_Normal_047202_g83242;
				half4 Weights52_g83263 = Terrain_Weights_087340_g83242;
				TEXTURE2D(Texture238_g83307) = _NormalTex5;
				SamplerState Sampler238_g83307 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83307 = Input_Coords_058750_g83242;
				half4 Coords238_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition238_g83307 = ase_worldPos;
				half4 localSamplePlanar2D238_g83307 = SamplePlanar2D( Texture238_g83307 , Sampler238_g83307 , Coords238_g83307 , WorldPosition238_g83307 );
				TEXTURE2D(Texture246_g83307) = _NormalTex5;
				SamplerState Sampler246_g83307 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition246_g83307 = ase_worldPos;
				half3 WorldNormal246_g83307 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83307 = SamplePlanar3D( Texture246_g83307 , Sampler246_g83307 , Coords246_g83307 , WorldPosition246_g83307 , WorldNormal246_g83307 );
				TEXTURE2D(Texture234_g83307) = _NormalTex5;
				SamplerState Sampler234_g83307 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83307 = temp_output_37_0_g83307;
				float3 WorldPosition234_g83307 = ase_worldPos;
				float4 localSampleStochastic2D234_g83307 = SampleStochastic2D( Texture234_g83307 , Sampler234_g83307 , Coords234_g83307 , WorldPosition234_g83307 );
				TEXTURE2D(Texture263_g83307) = _NormalTex5;
				SamplerState Sampler263_g83307 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition263_g83307 = ase_worldPos;
				half3 WorldNormal263_g83307 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83307 = SampleStochastic3D( Texture263_g83307 , Sampler263_g83307 , Coords263_g83307 , WorldPosition263_g83307 , WorldNormal263_g83307 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8686_g83242 = localSamplePlanar2D238_g83307;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8686_g83242 = localSamplePlanar3D246_g83307;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8686_g83242 = localSampleStochastic2D234_g83307;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8686_g83242 = localSampleStochastic3D263_g83307;
				#else
				float4 staticSwitch8686_g83242 = localSamplePlanar2D238_g83307;
				#endif
				half4 Layer133_g83263 = staticSwitch8686_g83242;
				TEXTURE2D(Texture238_g83308) = _NormalTex6;
				SamplerState Sampler238_g83308 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83308 = Input_Coords_068751_g83242;
				half4 Coords238_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition238_g83308 = ase_worldPos;
				half4 localSamplePlanar2D238_g83308 = SamplePlanar2D( Texture238_g83308 , Sampler238_g83308 , Coords238_g83308 , WorldPosition238_g83308 );
				TEXTURE2D(Texture246_g83308) = _NormalTex6;
				SamplerState Sampler246_g83308 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition246_g83308 = ase_worldPos;
				half3 WorldNormal246_g83308 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83308 = SamplePlanar3D( Texture246_g83308 , Sampler246_g83308 , Coords246_g83308 , WorldPosition246_g83308 , WorldNormal246_g83308 );
				TEXTURE2D(Texture234_g83308) = _NormalTex6;
				SamplerState Sampler234_g83308 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83308 = temp_output_37_0_g83308;
				float3 WorldPosition234_g83308 = ase_worldPos;
				float4 localSampleStochastic2D234_g83308 = SampleStochastic2D( Texture234_g83308 , Sampler234_g83308 , Coords234_g83308 , WorldPosition234_g83308 );
				TEXTURE2D(Texture263_g83308) = _NormalTex6;
				SamplerState Sampler263_g83308 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition263_g83308 = ase_worldPos;
				half3 WorldNormal263_g83308 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83308 = SampleStochastic3D( Texture263_g83308 , Sampler263_g83308 , Coords263_g83308 , WorldPosition263_g83308 , WorldNormal263_g83308 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8687_g83242 = localSamplePlanar2D238_g83308;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8687_g83242 = localSamplePlanar3D246_g83308;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8687_g83242 = localSampleStochastic2D234_g83308;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8687_g83242 = localSampleStochastic3D263_g83308;
				#else
				float4 staticSwitch8687_g83242 = localSamplePlanar2D238_g83308;
				#endif
				half4 Layer237_g83263 = staticSwitch8687_g83242;
				TEXTURE2D(Texture238_g83309) = _NormalTex7;
				SamplerState Sampler238_g83309 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83309 = Input_Coords_078752_g83242;
				half4 Coords238_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition238_g83309 = ase_worldPos;
				half4 localSamplePlanar2D238_g83309 = SamplePlanar2D( Texture238_g83309 , Sampler238_g83309 , Coords238_g83309 , WorldPosition238_g83309 );
				TEXTURE2D(Texture246_g83309) = _NormalTex7;
				SamplerState Sampler246_g83309 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition246_g83309 = ase_worldPos;
				half3 WorldNormal246_g83309 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83309 = SamplePlanar3D( Texture246_g83309 , Sampler246_g83309 , Coords246_g83309 , WorldPosition246_g83309 , WorldNormal246_g83309 );
				TEXTURE2D(Texture234_g83309) = _NormalTex7;
				SamplerState Sampler234_g83309 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83309 = temp_output_37_0_g83309;
				float3 WorldPosition234_g83309 = ase_worldPos;
				float4 localSampleStochastic2D234_g83309 = SampleStochastic2D( Texture234_g83309 , Sampler234_g83309 , Coords234_g83309 , WorldPosition234_g83309 );
				TEXTURE2D(Texture263_g83309) = _NormalTex7;
				SamplerState Sampler263_g83309 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition263_g83309 = ase_worldPos;
				half3 WorldNormal263_g83309 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83309 = SampleStochastic3D( Texture263_g83309 , Sampler263_g83309 , Coords263_g83309 , WorldPosition263_g83309 , WorldNormal263_g83309 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8688_g83242 = localSamplePlanar2D238_g83309;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8688_g83242 = localSamplePlanar3D246_g83309;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8688_g83242 = localSampleStochastic2D234_g83309;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8688_g83242 = localSampleStochastic3D263_g83309;
				#else
				float4 staticSwitch8688_g83242 = localSamplePlanar2D238_g83309;
				#endif
				half4 Layer338_g83263 = staticSwitch8688_g83242;
				TEXTURE2D(Texture238_g83310) = _NormalTex8;
				SamplerState Sampler238_g83310 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83310 = Input_Coords_088749_g83242;
				half4 Coords238_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition238_g83310 = ase_worldPos;
				half4 localSamplePlanar2D238_g83310 = SamplePlanar2D( Texture238_g83310 , Sampler238_g83310 , Coords238_g83310 , WorldPosition238_g83310 );
				TEXTURE2D(Texture246_g83310) = _NormalTex8;
				SamplerState Sampler246_g83310 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition246_g83310 = ase_worldPos;
				half3 WorldNormal246_g83310 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83310 = SamplePlanar3D( Texture246_g83310 , Sampler246_g83310 , Coords246_g83310 , WorldPosition246_g83310 , WorldNormal246_g83310 );
				TEXTURE2D(Texture234_g83310) = _NormalTex8;
				SamplerState Sampler234_g83310 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83310 = temp_output_37_0_g83310;
				float3 WorldPosition234_g83310 = ase_worldPos;
				float4 localSampleStochastic2D234_g83310 = SampleStochastic2D( Texture234_g83310 , Sampler234_g83310 , Coords234_g83310 , WorldPosition234_g83310 );
				TEXTURE2D(Texture263_g83310) = _NormalTex8;
				SamplerState Sampler263_g83310 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition263_g83310 = ase_worldPos;
				half3 WorldNormal263_g83310 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83310 = SampleStochastic3D( Texture263_g83310 , Sampler263_g83310 , Coords263_g83310 , WorldPosition263_g83310 , WorldNormal263_g83310 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8689_g83242 = localSamplePlanar2D238_g83310;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8689_g83242 = localSamplePlanar3D246_g83310;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8689_g83242 = localSampleStochastic2D234_g83310;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8689_g83242 = localSampleStochastic3D263_g83310;
				#else
				float4 staticSwitch8689_g83242 = localSamplePlanar2D238_g83310;
				#endif
				half4 Layer439_g83263 = staticSwitch8689_g83242;
				float4 weightedBlendVar31_g83263 = Weights52_g83263;
				float4 weightedBlend31_g83263 = ( weightedBlendVar31_g83263.x*Layer133_g83263 + weightedBlendVar31_g83263.y*Layer237_g83263 + weightedBlendVar31_g83263.z*Layer338_g83263 + weightedBlendVar31_g83263.w*Layer439_g83263 );
				half4 Terrain_Normal_088684_g83242 = weightedBlend31_g83263;
				half4 Layer_0810_g83257 = Terrain_Normal_088684_g83242;
				half4 Weights52_g83273 = Terrain_Weights_127710_g83242;
				TEXTURE2D(Texture238_g83319) = _NormalTex9;
				SamplerState Sampler238_g83319 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83319 = Input_Coords_098833_g83242;
				half4 Coords238_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition238_g83319 = ase_worldPos;
				half4 localSamplePlanar2D238_g83319 = SamplePlanar2D( Texture238_g83319 , Sampler238_g83319 , Coords238_g83319 , WorldPosition238_g83319 );
				TEXTURE2D(Texture246_g83319) = _NormalTex9;
				SamplerState Sampler246_g83319 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition246_g83319 = ase_worldPos;
				half3 WorldNormal246_g83319 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83319 = SamplePlanar3D( Texture246_g83319 , Sampler246_g83319 , Coords246_g83319 , WorldPosition246_g83319 , WorldNormal246_g83319 );
				TEXTURE2D(Texture234_g83319) = _NormalTex9;
				SamplerState Sampler234_g83319 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83319 = temp_output_37_0_g83319;
				float3 WorldPosition234_g83319 = ase_worldPos;
				float4 localSampleStochastic2D234_g83319 = SampleStochastic2D( Texture234_g83319 , Sampler234_g83319 , Coords234_g83319 , WorldPosition234_g83319 );
				TEXTURE2D(Texture263_g83319) = _NormalTex9;
				SamplerState Sampler263_g83319 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition263_g83319 = ase_worldPos;
				half3 WorldNormal263_g83319 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83319 = SampleStochastic3D( Texture263_g83319 , Sampler263_g83319 , Coords263_g83319 , WorldPosition263_g83319 , WorldNormal263_g83319 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8849_g83242 = localSamplePlanar2D238_g83319;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8849_g83242 = localSamplePlanar3D246_g83319;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8849_g83242 = localSampleStochastic2D234_g83319;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8849_g83242 = localSampleStochastic3D263_g83319;
				#else
				float4 staticSwitch8849_g83242 = localSamplePlanar2D238_g83319;
				#endif
				half4 Layer133_g83273 = staticSwitch8849_g83242;
				TEXTURE2D(Texture238_g83320) = _NormalTex10;
				SamplerState Sampler238_g83320 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83320 = Input_Coords_108834_g83242;
				half4 Coords238_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition238_g83320 = ase_worldPos;
				half4 localSamplePlanar2D238_g83320 = SamplePlanar2D( Texture238_g83320 , Sampler238_g83320 , Coords238_g83320 , WorldPosition238_g83320 );
				TEXTURE2D(Texture246_g83320) = _NormalTex10;
				SamplerState Sampler246_g83320 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition246_g83320 = ase_worldPos;
				half3 WorldNormal246_g83320 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83320 = SamplePlanar3D( Texture246_g83320 , Sampler246_g83320 , Coords246_g83320 , WorldPosition246_g83320 , WorldNormal246_g83320 );
				TEXTURE2D(Texture234_g83320) = _NormalTex10;
				SamplerState Sampler234_g83320 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83320 = temp_output_37_0_g83320;
				float3 WorldPosition234_g83320 = ase_worldPos;
				float4 localSampleStochastic2D234_g83320 = SampleStochastic2D( Texture234_g83320 , Sampler234_g83320 , Coords234_g83320 , WorldPosition234_g83320 );
				TEXTURE2D(Texture263_g83320) = _NormalTex10;
				SamplerState Sampler263_g83320 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition263_g83320 = ase_worldPos;
				half3 WorldNormal263_g83320 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83320 = SampleStochastic3D( Texture263_g83320 , Sampler263_g83320 , Coords263_g83320 , WorldPosition263_g83320 , WorldNormal263_g83320 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8876_g83242 = localSamplePlanar2D238_g83320;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8876_g83242 = localSamplePlanar3D246_g83320;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8876_g83242 = localSampleStochastic2D234_g83320;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8876_g83242 = localSampleStochastic3D263_g83320;
				#else
				float4 staticSwitch8876_g83242 = localSamplePlanar2D238_g83320;
				#endif
				half4 Layer237_g83273 = staticSwitch8876_g83242;
				TEXTURE2D(Texture238_g83321) = _NormalTex11;
				SamplerState Sampler238_g83321 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83321 = Input_Coords_118835_g83242;
				half4 Coords238_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition238_g83321 = ase_worldPos;
				half4 localSamplePlanar2D238_g83321 = SamplePlanar2D( Texture238_g83321 , Sampler238_g83321 , Coords238_g83321 , WorldPosition238_g83321 );
				TEXTURE2D(Texture246_g83321) = _NormalTex11;
				SamplerState Sampler246_g83321 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition246_g83321 = ase_worldPos;
				half3 WorldNormal246_g83321 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83321 = SamplePlanar3D( Texture246_g83321 , Sampler246_g83321 , Coords246_g83321 , WorldPosition246_g83321 , WorldNormal246_g83321 );
				TEXTURE2D(Texture234_g83321) = _NormalTex11;
				SamplerState Sampler234_g83321 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83321 = temp_output_37_0_g83321;
				float3 WorldPosition234_g83321 = ase_worldPos;
				float4 localSampleStochastic2D234_g83321 = SampleStochastic2D( Texture234_g83321 , Sampler234_g83321 , Coords234_g83321 , WorldPosition234_g83321 );
				TEXTURE2D(Texture263_g83321) = _NormalTex11;
				SamplerState Sampler263_g83321 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition263_g83321 = ase_worldPos;
				half3 WorldNormal263_g83321 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83321 = SampleStochastic3D( Texture263_g83321 , Sampler263_g83321 , Coords263_g83321 , WorldPosition263_g83321 , WorldNormal263_g83321 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8850_g83242 = localSamplePlanar2D238_g83321;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8850_g83242 = localSamplePlanar3D246_g83321;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8850_g83242 = localSampleStochastic2D234_g83321;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8850_g83242 = localSampleStochastic3D263_g83321;
				#else
				float4 staticSwitch8850_g83242 = localSamplePlanar2D238_g83321;
				#endif
				half4 Layer338_g83273 = staticSwitch8850_g83242;
				TEXTURE2D(Texture238_g83322) = _NormalTex12;
				SamplerState Sampler238_g83322 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83322 = Input_Coords_128836_g83242;
				half4 Coords238_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition238_g83322 = ase_worldPos;
				half4 localSamplePlanar2D238_g83322 = SamplePlanar2D( Texture238_g83322 , Sampler238_g83322 , Coords238_g83322 , WorldPosition238_g83322 );
				TEXTURE2D(Texture246_g83322) = _NormalTex12;
				SamplerState Sampler246_g83322 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition246_g83322 = ase_worldPos;
				half3 WorldNormal246_g83322 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83322 = SamplePlanar3D( Texture246_g83322 , Sampler246_g83322 , Coords246_g83322 , WorldPosition246_g83322 , WorldNormal246_g83322 );
				TEXTURE2D(Texture234_g83322) = _NormalTex12;
				SamplerState Sampler234_g83322 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83322 = temp_output_37_0_g83322;
				float3 WorldPosition234_g83322 = ase_worldPos;
				float4 localSampleStochastic2D234_g83322 = SampleStochastic2D( Texture234_g83322 , Sampler234_g83322 , Coords234_g83322 , WorldPosition234_g83322 );
				TEXTURE2D(Texture263_g83322) = _NormalTex12;
				SamplerState Sampler263_g83322 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition263_g83322 = ase_worldPos;
				half3 WorldNormal263_g83322 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83322 = SampleStochastic3D( Texture263_g83322 , Sampler263_g83322 , Coords263_g83322 , WorldPosition263_g83322 , WorldNormal263_g83322 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8877_g83242 = localSamplePlanar2D238_g83322;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8877_g83242 = localSamplePlanar3D246_g83322;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8877_g83242 = localSampleStochastic2D234_g83322;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8877_g83242 = localSampleStochastic3D263_g83322;
				#else
				float4 staticSwitch8877_g83242 = localSamplePlanar2D238_g83322;
				#endif
				half4 Layer439_g83273 = staticSwitch8877_g83242;
				float4 weightedBlendVar31_g83273 = Weights52_g83273;
				float4 weightedBlend31_g83273 = ( weightedBlendVar31_g83273.x*Layer133_g83273 + weightedBlendVar31_g83273.y*Layer237_g83273 + weightedBlendVar31_g83273.z*Layer338_g83273 + weightedBlendVar31_g83273.w*Layer439_g83273 );
				half4 Terrain_Normal_128865_g83242 = weightedBlend31_g83273;
				half4 Layer_1243_g83257 = Terrain_Normal_128865_g83242;
				half4 Weights52_g83283 = Terrain_Weights_167709_g83242;
				TEXTURE2D(Texture238_g83338) = _NormalTex13;
				SamplerState Sampler238_g83338 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83338 = Input_Coords_138960_g83242;
				half4 Coords238_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition238_g83338 = ase_worldPos;
				half4 localSamplePlanar2D238_g83338 = SamplePlanar2D( Texture238_g83338 , Sampler238_g83338 , Coords238_g83338 , WorldPosition238_g83338 );
				TEXTURE2D(Texture246_g83338) = _NormalTex13;
				SamplerState Sampler246_g83338 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition246_g83338 = ase_worldPos;
				half3 WorldNormal246_g83338 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83338 = SamplePlanar3D( Texture246_g83338 , Sampler246_g83338 , Coords246_g83338 , WorldPosition246_g83338 , WorldNormal246_g83338 );
				TEXTURE2D(Texture234_g83338) = _NormalTex13;
				SamplerState Sampler234_g83338 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83338 = temp_output_37_0_g83338;
				float3 WorldPosition234_g83338 = ase_worldPos;
				float4 localSampleStochastic2D234_g83338 = SampleStochastic2D( Texture234_g83338 , Sampler234_g83338 , Coords234_g83338 , WorldPosition234_g83338 );
				TEXTURE2D(Texture263_g83338) = _NormalTex13;
				SamplerState Sampler263_g83338 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition263_g83338 = ase_worldPos;
				half3 WorldNormal263_g83338 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83338 = SampleStochastic3D( Texture263_g83338 , Sampler263_g83338 , Coords263_g83338 , WorldPosition263_g83338 , WorldNormal263_g83338 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch8991_g83242 = localSamplePlanar2D238_g83338;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch8991_g83242 = localSamplePlanar3D246_g83338;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch8991_g83242 = localSampleStochastic2D234_g83338;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch8991_g83242 = localSampleStochastic3D263_g83338;
				#else
				float4 staticSwitch8991_g83242 = localSamplePlanar2D238_g83338;
				#endif
				half4 Layer133_g83283 = staticSwitch8991_g83242;
				TEXTURE2D(Texture238_g83331) = _NormalTex14;
				SamplerState Sampler238_g83331 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83331 = Input_Coords_148961_g83242;
				half4 Coords238_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition238_g83331 = ase_worldPos;
				half4 localSamplePlanar2D238_g83331 = SamplePlanar2D( Texture238_g83331 , Sampler238_g83331 , Coords238_g83331 , WorldPosition238_g83331 );
				TEXTURE2D(Texture246_g83331) = _NormalTex14;
				SamplerState Sampler246_g83331 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition246_g83331 = ase_worldPos;
				half3 WorldNormal246_g83331 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83331 = SamplePlanar3D( Texture246_g83331 , Sampler246_g83331 , Coords246_g83331 , WorldPosition246_g83331 , WorldNormal246_g83331 );
				TEXTURE2D(Texture234_g83331) = _NormalTex14;
				SamplerState Sampler234_g83331 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83331 = temp_output_37_0_g83331;
				float3 WorldPosition234_g83331 = ase_worldPos;
				float4 localSampleStochastic2D234_g83331 = SampleStochastic2D( Texture234_g83331 , Sampler234_g83331 , Coords234_g83331 , WorldPosition234_g83331 );
				TEXTURE2D(Texture263_g83331) = _NormalTex14;
				SamplerState Sampler263_g83331 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition263_g83331 = ase_worldPos;
				half3 WorldNormal263_g83331 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83331 = SampleStochastic3D( Texture263_g83331 , Sampler263_g83331 , Coords263_g83331 , WorldPosition263_g83331 , WorldNormal263_g83331 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch8990_g83242 = localSamplePlanar2D238_g83331;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch8990_g83242 = localSamplePlanar3D246_g83331;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch8990_g83242 = localSampleStochastic2D234_g83331;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch8990_g83242 = localSampleStochastic3D263_g83331;
				#else
				float4 staticSwitch8990_g83242 = localSamplePlanar2D238_g83331;
				#endif
				half4 Layer237_g83283 = staticSwitch8990_g83242;
				TEXTURE2D(Texture238_g83332) = _NormalTex15;
				SamplerState Sampler238_g83332 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83332 = Input_Coords_158962_g83242;
				half4 Coords238_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition238_g83332 = ase_worldPos;
				half4 localSamplePlanar2D238_g83332 = SamplePlanar2D( Texture238_g83332 , Sampler238_g83332 , Coords238_g83332 , WorldPosition238_g83332 );
				TEXTURE2D(Texture246_g83332) = _NormalTex15;
				SamplerState Sampler246_g83332 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition246_g83332 = ase_worldPos;
				half3 WorldNormal246_g83332 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83332 = SamplePlanar3D( Texture246_g83332 , Sampler246_g83332 , Coords246_g83332 , WorldPosition246_g83332 , WorldNormal246_g83332 );
				TEXTURE2D(Texture234_g83332) = _NormalTex15;
				SamplerState Sampler234_g83332 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83332 = temp_output_37_0_g83332;
				float3 WorldPosition234_g83332 = ase_worldPos;
				float4 localSampleStochastic2D234_g83332 = SampleStochastic2D( Texture234_g83332 , Sampler234_g83332 , Coords234_g83332 , WorldPosition234_g83332 );
				TEXTURE2D(Texture263_g83332) = _NormalTex15;
				SamplerState Sampler263_g83332 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition263_g83332 = ase_worldPos;
				half3 WorldNormal263_g83332 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83332 = SampleStochastic3D( Texture263_g83332 , Sampler263_g83332 , Coords263_g83332 , WorldPosition263_g83332 , WorldNormal263_g83332 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch8989_g83242 = localSamplePlanar2D238_g83332;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch8989_g83242 = localSamplePlanar3D246_g83332;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch8989_g83242 = localSampleStochastic2D234_g83332;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch8989_g83242 = localSampleStochastic3D263_g83332;
				#else
				float4 staticSwitch8989_g83242 = localSamplePlanar2D238_g83332;
				#endif
				half4 Layer338_g83283 = staticSwitch8989_g83242;
				TEXTURE2D(Texture238_g83333) = _NormalTex16;
				SamplerState Sampler238_g83333 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83333 = Input_Coords_168959_g83242;
				half4 Coords238_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition238_g83333 = ase_worldPos;
				half4 localSamplePlanar2D238_g83333 = SamplePlanar2D( Texture238_g83333 , Sampler238_g83333 , Coords238_g83333 , WorldPosition238_g83333 );
				TEXTURE2D(Texture246_g83333) = _NormalTex16;
				SamplerState Sampler246_g83333 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition246_g83333 = ase_worldPos;
				half3 WorldNormal246_g83333 = ase_worldNormal;
				half4 localSamplePlanar3D246_g83333 = SamplePlanar3D( Texture246_g83333 , Sampler246_g83333 , Coords246_g83333 , WorldPosition246_g83333 , WorldNormal246_g83333 );
				TEXTURE2D(Texture234_g83333) = _NormalTex16;
				SamplerState Sampler234_g83333 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83333 = temp_output_37_0_g83333;
				float3 WorldPosition234_g83333 = ase_worldPos;
				float4 localSampleStochastic2D234_g83333 = SampleStochastic2D( Texture234_g83333 , Sampler234_g83333 , Coords234_g83333 , WorldPosition234_g83333 );
				TEXTURE2D(Texture263_g83333) = _NormalTex16;
				SamplerState Sampler263_g83333 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition263_g83333 = ase_worldPos;
				half3 WorldNormal263_g83333 = ase_worldNormal;
				half4 localSampleStochastic3D263_g83333 = SampleStochastic3D( Texture263_g83333 , Sampler263_g83333 , Coords263_g83333 , WorldPosition263_g83333 , WorldNormal263_g83333 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch8988_g83242 = localSamplePlanar2D238_g83333;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch8988_g83242 = localSamplePlanar3D246_g83333;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch8988_g83242 = localSampleStochastic2D234_g83333;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch8988_g83242 = localSampleStochastic3D263_g83333;
				#else
				float4 staticSwitch8988_g83242 = localSamplePlanar2D238_g83333;
				#endif
				half4 Layer439_g83283 = staticSwitch8988_g83242;
				float4 weightedBlendVar31_g83283 = Weights52_g83283;
				float4 weightedBlend31_g83283 = ( weightedBlendVar31_g83283.x*Layer133_g83283 + weightedBlendVar31_g83283.y*Layer237_g83283 + weightedBlendVar31_g83283.z*Layer338_g83283 + weightedBlendVar31_g83283.w*Layer439_g83283 );
				half4 Terrain_Normal_168987_g83242 = weightedBlend31_g83283;
				half4 Layer_1644_g83257 = Terrain_Normal_168987_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83257 = Layer_045_g83257;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 + Layer_1243_g83257 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 + Layer_1243_g83257 + Layer_1644_g83257 );
				#else
				float4 staticSwitch40_g83257 = Layer_045_g83257;
				#endif
				half4 Blend_Normal7512_g83242 = staticSwitch40_g83257;
				half4 Normal_Packed45_g83244 = Blend_Normal7512_g83242;
				float2 appendResult58_g83244 = (float2(( (Normal_Packed45_g83244).x * (Normal_Packed45_g83244).w ) , (Normal_Packed45_g83244).y));
				half2 Normal_Default50_g83244 = appendResult58_g83244;
				half2 Normal_ASTC41_g83244 = (Normal_Packed45_g83244).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g83244 = Normal_ASTC41_g83244;
				#else
				float2 staticSwitch38_g83244 = Normal_Default50_g83244;
				#endif
				half2 Normal_NO_DTX544_g83244 = (Normal_Packed45_g83244).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g83244 = Normal_NO_DTX544_g83244;
				#else
				float2 staticSwitch37_g83244 = staticSwitch38_g83244;
				#endif
				half4 Weights52_g83249 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83249 = temp_output_6970_0_g83242;
				half4 Layer237_g83249 = temp_output_6977_0_g83242;
				half4 Layer338_g83249 = temp_output_6978_0_g83242;
				half4 Layer439_g83249 = temp_output_6983_0_g83242;
				float4 weightedBlendVar31_g83249 = Weights52_g83249;
				float4 weightedBlend31_g83249 = ( weightedBlendVar31_g83249.x*Layer133_g83249 + weightedBlendVar31_g83249.y*Layer237_g83249 + weightedBlendVar31_g83249.z*Layer338_g83249 + weightedBlendVar31_g83249.w*Layer439_g83249 );
				half4 Terrain_Masks_047203_g83242 = weightedBlend31_g83249;
				half4 Layer_045_g83259 = Terrain_Masks_047203_g83242;
				half4 Weights52_g83266 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83266 = temp_output_8714_0_g83242;
				half4 Layer237_g83266 = temp_output_8721_0_g83242;
				half4 Layer338_g83266 = temp_output_8724_0_g83242;
				half4 Layer439_g83266 = temp_output_8727_0_g83242;
				float4 weightedBlendVar31_g83266 = Weights52_g83266;
				float4 weightedBlend31_g83266 = ( weightedBlendVar31_g83266.x*Layer133_g83266 + weightedBlendVar31_g83266.y*Layer237_g83266 + weightedBlendVar31_g83266.z*Layer338_g83266 + weightedBlendVar31_g83266.w*Layer439_g83266 );
				half4 Terrain_Masks_088730_g83242 = weightedBlend31_g83266;
				half4 Layer_0810_g83259 = Terrain_Masks_088730_g83242;
				half4 Weights52_g83276 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83276 = temp_output_8815_0_g83242;
				half4 Layer237_g83276 = temp_output_8818_0_g83242;
				half4 Layer338_g83276 = temp_output_8819_0_g83242;
				half4 Layer439_g83276 = temp_output_8820_0_g83242;
				float4 weightedBlendVar31_g83276 = Weights52_g83276;
				float4 weightedBlend31_g83276 = ( weightedBlendVar31_g83276.x*Layer133_g83276 + weightedBlendVar31_g83276.y*Layer237_g83276 + weightedBlendVar31_g83276.z*Layer338_g83276 + weightedBlendVar31_g83276.w*Layer439_g83276 );
				half4 Terrain_Masks_128871_g83242 = weightedBlend31_g83276;
				half4 Layer_1243_g83259 = Terrain_Masks_128871_g83242;
				half4 Weights52_g83286 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83286 = temp_output_8931_0_g83242;
				half4 Layer237_g83286 = temp_output_8934_0_g83242;
				half4 Layer338_g83286 = temp_output_8935_0_g83242;
				half4 Layer439_g83286 = temp_output_8936_0_g83242;
				float4 weightedBlendVar31_g83286 = Weights52_g83286;
				float4 weightedBlend31_g83286 = ( weightedBlendVar31_g83286.x*Layer133_g83286 + weightedBlendVar31_g83286.y*Layer237_g83286 + weightedBlendVar31_g83286.z*Layer338_g83286 + weightedBlendVar31_g83286.w*Layer439_g83286 );
				half4 Terrain_Masks_169014_g83242 = weightedBlend31_g83286;
				half4 Layer_1644_g83259 = Terrain_Masks_169014_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83259 = Layer_045_g83259;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 + Layer_1243_g83259 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 + Layer_1243_g83259 + Layer_1644_g83259 );
				#else
				float4 staticSwitch40_g83259 = Layer_045_g83259;
				#endif
				half4 Blend_Masks7420_g83242 = staticSwitch40_g83259;
				half4 Normal_Packed45_g83243 = Blend_Masks7420_g83242;
				half2 Normal_NO_DTX544_g83243 = (Normal_Packed45_g83243).wy;
				#ifdef TVE_PACKED_TEX
				float2 staticSwitch8562_g83242 = (Normal_NO_DTX544_g83243*2.0 + -1.0);
				#else
				float2 staticSwitch8562_g83242 = (staticSwitch37_g83244*2.0 + -1.0);
				#endif
				half4 Weights52_g83253 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83253 = _Params1;
				half4 Layer237_g83253 = _Params2;
				half4 Layer338_g83253 = _Params3;
				half4 Layer439_g83253 = _Params4;
				float4 weightedBlendVar31_g83253 = Weights52_g83253;
				float4 weightedBlend31_g83253 = ( weightedBlendVar31_g83253.x*Layer133_g83253 + weightedBlendVar31_g83253.y*Layer237_g83253 + weightedBlendVar31_g83253.z*Layer338_g83253 + weightedBlendVar31_g83253.w*Layer439_g83253 );
				half4 Terrain_Params_047533_g83242 = weightedBlend31_g83253;
				half4 Layer_045_g83260 = Terrain_Params_047533_g83242;
				half4 Weights52_g83270 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83270 = _Params5;
				half4 Layer237_g83270 = _Params6;
				half4 Layer338_g83270 = _Params7;
				half4 Layer439_g83270 = _Params8;
				float4 weightedBlendVar31_g83270 = Weights52_g83270;
				float4 weightedBlend31_g83270 = ( weightedBlendVar31_g83270.x*Layer133_g83270 + weightedBlendVar31_g83270.y*Layer237_g83270 + weightedBlendVar31_g83270.z*Layer338_g83270 + weightedBlendVar31_g83270.w*Layer439_g83270 );
				half4 Terrain_Params_088739_g83242 = weightedBlend31_g83270;
				half4 Layer_0810_g83260 = Terrain_Params_088739_g83242;
				half4 Weights52_g83280 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83280 = _Params9;
				half4 Layer237_g83280 = _Params10;
				half4 Layer338_g83280 = _Params11;
				half4 Layer439_g83280 = _Params12;
				float4 weightedBlendVar31_g83280 = Weights52_g83280;
				float4 weightedBlend31_g83280 = ( weightedBlendVar31_g83280.x*Layer133_g83280 + weightedBlendVar31_g83280.y*Layer237_g83280 + weightedBlendVar31_g83280.z*Layer338_g83280 + weightedBlendVar31_g83280.w*Layer439_g83280 );
				half4 Terrain_Params_128867_g83242 = weightedBlend31_g83280;
				half4 Layer_1243_g83260 = Terrain_Params_128867_g83242;
				half4 Weights52_g83290 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83290 = _Params13;
				half4 Layer237_g83290 = _Params14;
				half4 Layer338_g83290 = _Params15;
				half4 Layer439_g83290 = _Params16;
				float4 weightedBlendVar31_g83290 = Weights52_g83290;
				float4 weightedBlend31_g83290 = ( weightedBlendVar31_g83290.x*Layer133_g83290 + weightedBlendVar31_g83290.y*Layer237_g83290 + weightedBlendVar31_g83290.z*Layer338_g83290 + weightedBlendVar31_g83290.w*Layer439_g83290 );
				half4 Terrain_Params_169017_g83242 = weightedBlend31_g83290;
				half4 Layer_1644_g83260 = Terrain_Params_169017_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83260 = Layer_045_g83260;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 + Layer_1243_g83260 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 + Layer_1243_g83260 + Layer_1644_g83260 );
				#else
				float4 staticSwitch40_g83260 = Layer_045_g83260;
				#endif
				half4 Blend_Params7547_g83242 = staticSwitch40_g83260;
				half2 Normal_Planar45_g83246 = ( staticSwitch8562_g83242 * (Blend_Params7547_g83242).z );
				float2 break64_g83246 = Normal_Planar45_g83246;
				float3 appendResult65_g83246 = (float3(break64_g83246.x , 0.0 , break64_g83246.y));
				half2 Terrain_Normal6871_g79798 = (mul( ase_worldToTangent, appendResult65_g83246 )).xy;
				float2 temp_output_7045_0_g79798 = ( Terrain_Normal6871_g79798 * _TerrainNormalValue );
				float3 appendResult7219_g79798 = (float3(temp_output_7045_0_g79798 , 1.0));
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 tanNormal7220_g79798 = appendResult7219_g79798;
				float3 worldNormal7220_g79798 = normalize( float3(dot(tanToWorld0,tanNormal7220_g79798), dot(tanToWorld1,tanNormal7220_g79798), dot(tanToWorld2,tanNormal7220_g79798)) );
				half3 Blend_Normal_WS7221_g79798 = worldNormal7220_g79798;
				float temp_output_7222_0_g79798 = (Blend_Normal_WS7221_g79798).y;
				float lerpResult6757_g79798 = lerp( 1.0 , saturate( temp_output_7222_0_g79798 ) , _OverlayProjectionValue);
				half Overlay_Projection6081_g79798 = lerpResult6757_g79798;
				half Overlay_Shading6688_g79798 = Blend_Albedo_Globals6410_g79798;
				half Overlay_Custom6707_g79798 = 1.0;
				float temp_output_7_0_g79848 = 0.1;
				float temp_output_10_0_g79848 = ( 0.2 - temp_output_7_0_g79848 );
				half Overlay_Mask_High6064_g79798 = saturate( ( ( ( Overlay_Value5738_g79798 * Overlay_Projection6081_g79798 * Overlay_Shading6688_g79798 * Overlay_Custom6707_g79798 ) - temp_output_7_0_g79848 ) / ( temp_output_10_0_g79848 + 0.0001 ) ) );
				half Overlay_Mask269_g79798 = Overlay_Mask_High6064_g79798;
				float3 lerpResult336_g79798 = lerp( Blend_Albedo_Colored863_g79798 , Global_OverlayColor1758_g79798 , Overlay_Mask269_g79798);
				half3 Blend_Albedo_Overlay359_g79798 = lerpResult336_g79798;
				half Global_WetnessContrast6502_g79798 = TVE_WetnessContrast;
				half Global_Extras_Wetness305_g79798 = break456_g79805.y;
				half Wetness_Value6343_g79798 = ( Global_Extras_Wetness305_g79798 * _GlobalWetness );
				float3 lerpResult6367_g79798 = lerp( Blend_Albedo_Overlay359_g79798 , ( Blend_Albedo_Overlay359_g79798 * Blend_Albedo_Overlay359_g79798 ) , ( Global_WetnessContrast6502_g79798 * Wetness_Value6343_g79798 ));
				half3 Blend_Albedo_Wetness6351_g79798 = lerpResult6367_g79798;
				
				half2 Blend_Normal312_g79798 = temp_output_7045_0_g79798;
				half Global_OverlayNormalScale6581_g79798 = TVE_OverlayNormalValue;
				float lerpResult6585_g79798 = lerp( 1.0 , Global_OverlayNormalScale6581_g79798 , Overlay_Mask269_g79798);
				half2 Blend_Normal_Overlay366_g79798 = ( Blend_Normal312_g79798 * lerpResult6585_g79798 );
				half Global_WetnessNormalScale6571_g79798 = TVE_WetnessNormalValue;
				float lerpResult6579_g79798 = lerp( 1.0 , Global_WetnessNormalScale6571_g79798 , ( Wetness_Value6343_g79798 * Wetness_Value6343_g79798 ));
				half2 Blend_Normal_Wetness6372_g79798 = ( Blend_Normal_Overlay366_g79798 * lerpResult6579_g79798 );
				float3 appendResult6568_g79798 = (float3(Blend_Normal_Wetness6372_g79798 , 1.0));
				
				float3 temp_cast_17 = (0.0).xxx;
				float3 lerpResult7362_g79798 = lerp( float3( 1,1,1 ) , (Terrain_Albedo6800_g79798).xyz , _EmissiveAlbedoMode);
				half3 Emissive_Color7279_g79798 = ( (_EmissiveColor).rgb * (Terrain_Specular7322_g79798).rgb * lerpResult7362_g79798 );
				half Emissive_Texture7282_g79798 = (Terrain_Albedo6800_g79798).w;
				half Global_Extras_Emissive4203_g79798 = break456_g79805.x;
				float lerpResult7266_g79798 = lerp( 1.0 , Global_Extras_Emissive4203_g79798 , _GlobalEmissive);
				half Emissive_Value7264_g79798 = ( lerpResult7266_g79798 * _EmissivePhaseValue );
				half Emissive_Mask7291_g79798 = saturate( ( Emissive_Texture7282_g79798 + ( Emissive_Value7264_g79798 - 1.0 ) ) );
				float3 temp_output_3_0_g79858 = ( Emissive_Color7279_g79798 * Emissive_Mask7291_g79798 );
				float temp_output_15_0_g79858 = _emissive_intensity_value;
				float3 hdEmission22_g79858 = ASEGetEmissionHDRColor(temp_output_3_0_g79858,temp_output_15_0_g79858,_EmissiveExposureValue,GetInverseCurrentExposureMultiplier());
				#ifdef TVE_EMISSIVE
				float3 staticSwitch7437_g79798 = hdEmission22_g79858;
				#else
				float3 staticSwitch7437_g79798 = temp_cast_17;
				#endif
				half3 Blend_Emissive7261_g79798 = staticSwitch7437_g79798;
				
				#ifdef TVE_PACKED_TEX
				float staticSwitch8571_g83242 = 0.0;
				#else
				float staticSwitch8571_g83242 = ( (Blend_Masks7420_g83242).x * (Blend_Params7547_g83242).x );
				#endif
				#ifdef TVE_PACKED_TEX
				float staticSwitch8559_g83242 = 1.0;
				#else
				float staticSwitch8559_g83242 = (Blend_Masks7420_g83242).y;
				#endif
				#ifdef TVE_PACKED_TEX
				float staticSwitch8560_g83242 = (Blend_Masks7420_g83242).x;
				#else
				float staticSwitch8560_g83242 = (Blend_Masks7420_g83242).w;
				#endif
				float4 appendResult8574_g83242 = (float4(staticSwitch8571_g83242 , staticSwitch8559_g83242 , (Blend_Masks7420_g83242).z , ( staticSwitch8560_g83242 * (Blend_Params7547_g83242).w )));
				half4 Terrain_Masks7251_g79798 = appendResult8574_g83242;
				half Blend_Smoothness314_g79798 = ( (Terrain_Masks7251_g79798).w * _TerrainSmoothnessValue );
				half Global_OverlaySmoothness311_g79798 = TVE_OverlaySmoothness;
				float lerpResult343_g79798 = lerp( Blend_Smoothness314_g79798 , Global_OverlaySmoothness311_g79798 , Overlay_Mask269_g79798);
				half Blend_Smoothness_Overlay371_g79798 = lerpResult343_g79798;
				float temp_output_6499_0_g79798 = ( 1.0 - Wetness_Value6343_g79798 );
				half Blend_Smoothness_Wetness4130_g79798 = saturate( ( Blend_Smoothness_Overlay371_g79798 + ( 1.0 - ( temp_output_6499_0_g79798 * temp_output_6499_0_g79798 ) ) ) );
				
				float lerpResult7046_g79798 = lerp( 1.0 , (Terrain_Masks7251_g79798).y , _TerrainOcclusionValue);
				half Blend_Occlusion7306_g79798 = lerpResult7046_g79798;
				
				float localCustomAlphaClip19_g83341 = ( 0.0 );
				half Terrain_Holes7437_g83242 = SAMPLE_TEXTURE2D( _HolesTex, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 ).r;
				half Terrain_Holes7159_g79798 = Terrain_Holes7437_g83242;
				half Global_Extras_Alpha1033_g79798 = saturate( break456_g79805.w );
				float lerpResult7479_g79798 = lerp( 1.0 , Global_Extras_Alpha1033_g79798 , _GlobalAlpha);
				half Alpha_Global7481_g79798 = lerpResult7479_g79798;
				half AlphaTreshold2132_g79798 = _AlphaClipValue;
				float temp_output_3_0_g83341 = ( ( Terrain_Holes7159_g79798 * Alpha_Global7481_g79798 ) - AlphaTreshold2132_g79798 );
				float Alpha19_g83341 = temp_output_3_0_g83341;
				float temp_output_15_0_g83341 = 0.01;
				float Treshold19_g83341 = temp_output_15_0_g83341;
				{
				#if defined (TVE_ALPHA_CLIP) || defined (TVE_ALPHA_FADE) || defined (TVE_ALPHA_GLOBAL)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#else
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#endif
				}
				
				surfaceDescription.BaseColor = Blend_Albedo_Wetness6351_g79798;
				surfaceDescription.Normal = appendResult6568_g79798;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = Blend_Emissive7261_g79798;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g79798;
				surfaceDescription.Occlusion = Blend_Occlusion7306_g79798;
				surfaceDescription.Alpha = Alpha19_g83341;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);
				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);
				LightTransportData lightTransportData = GetLightTransportData(surfaceData, builtinData, bsdfData);

				float4 res = float4( 0.0, 0.0, 0.0, 1.0 );
				UnityMetaInput metaInput;
				metaInput.Albedo = lightTransportData.diffuseColor.rgb;
				metaInput.Emission = lightTransportData.emissiveColor;

			#ifdef EDITOR_VISUALIZATION
				metaInput.VizUV = packedInput.VizUV;
				metaInput.LightCoord = packedInput.LightCoord;
			#endif
				res = UnityMetaFragment(metaInput);

				return res;
			}

			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			Cull [_CullMode]
			ZWrite On
			ZClip [_ZClip]
			ZTest LEqual
			ColorMask 0

			HLSLPROGRAM
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140011
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma multi_compile_fragment _ SHADOWS_SHADOWMASK

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_SHADOWS

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MaskMax8;
			half4 _Coords7;
			half4 _MaskMax6;
			half4 _MaskMin6;
			half4 _Coords6;
			half4 _MaskMax5;
			half4 _MaskMin5;
			half4 _Coords5;
			half4 _MaskMax4;
			half4 _MaskMin4;
			half4 _MaskMin7;
			half4 _Coords4;
			half4 _MaskMin3;
			half4 _Coords3;
			half4 _MaskMax2;
			half4 _MaskMin2;
			half4 _Coords2;
			half4 _MaskMax1;
			half4 _MaskMin1;
			half4 _Coords1;
			half4 _MaskMax16;
			half4 _MaskMax3;
			half4 _MaskMax7;
			half4 _Coords8;
			half4 _MaskMin8;
			half4 _MaskMin15;
			half4 _Coords15;
			half4 _MaskMax14;
			half4 _MaskMin14;
			half4 _Coords14;
			half4 _MaskMax13;
			half4 _MaskMin13;
			half4 _Coords13;
			half4 _MaskMax12;
			half4 _MaskMin12;
			half4 _Coords12;
			half4 _MaskMax11;
			half4 _MaskMin11;
			half4 _Coords11;
			half4 _MaskMax10;
			half4 _MaskMin10;
			half4 _Coords10;
			half4 _MaskMax9;
			half4 _MaskMin9;
			half4 _Coords9;
			half4 _MaskMin16;
			half4 _TerrainColor;
			half4 _MaskMax15;
			half4 _Coords16;
			half4 _Params5;
			half4 _Params2;
			half4 _Params3;
			half4 _Params4;
			half4 _Params6;
			half4 _Params7;
			half4 _Params8;
			half4 _Params1;
			half4 _Params9;
			half4 _Params11;
			half4 _Params12;
			half4 _Params13;
			half4 _Params14;
			half4 _Params15;
			half4 _Params16;
			half4 _Params10;
			half4 _Specular16;
			half4 _EmissiveColor;
			half4 _Specular7;
			half4 _Specular3;
			half4 _Specular4;
			half4 _Specular5;
			half4 _Specular6;
			half4 _Specular15;
			half4 _Specular8;
			half4 _Specular2;
			half4 _Specular9;
			half4 _Specular11;
			half4 _Specular12;
			half4 _Specular13;
			half4 _Specular14;
			half4 _Specular10;
			half4 _Specular1;
			half _EmissivePhaseValue;
			half _GlobalEmissive;
			half _TerrainSmoothnessValue;
			float _emissive_intensity_value;
			half _EmissiveAlbedoMode;
			half _TerrainOcclusionValue;
			half _EmissiveExposureValue;
			half _GlobalColors;
			half _OverlayProjectionValue;
			half _TerrainNormalValue;
			half _ColorsIntensityValue;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _TerrainHeightBlendValue;
			half _GlobalWetness;
			half _LayerColorsValue;
			half _CategoryGlobals;
			half _GlobalHeight;
			half _CategoryEmissive;
			half _CategoryMotion;
			half _EmissiveIntensityValue;
			half _EmissiveIntensityMode;
			half _EmissiveFlagMode;
			half _IsVersion;
			half _IsTerrainShader;
			half _CategoryRender;
			half _MessageTerrainEmissive;
			half _MessageTerrainColors;
			half _CategoryTerrain;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _IsCustomShader;
			half _IsShared;
			half _IsCollected;
			half _IsIdentifier;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceGlobalOptions;
			half _SpaceGlobalLocals;
			half _SpaceGlobalLayers;
			half _CategoryLayers;
			half _GlobalAlpha;
			half _TerrainLayersMode;
			half _TerrainBlendMode;
			half _LayerVertexValue;
			half _RenderClip;
			half _LayerSampleMode16;
			half _LayerSampleMode15;
			half _LayerSampleMode14;
			half _LayerSampleMode13;
			half _LayerSampleMode12;
			half _LayerSampleMode11;
			half _LayerSampleMode10;
			half _LayerSampleMode9;
			half _LayerSampleMode8;
			half _LayerSampleMode7;
			half _LayerSampleMode6;
			half _LayerSampleMode5;
			half _LayerSampleMode1;
			half _LayerSampleMode4;
			half _LayerSampleMode3;
			half _LayerSampleMode2;
			half _CategoryInputs;
			half _TerrainTexMode;
			half _RenderMode;
			half _RenderDecals;
			half _EmissiveMode;
			half _MessageTerrainMasks;
			half _AlphaClipValue;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(sampler_Linear_Clamp);
			half4 TVE_VertexParams;
			TEXTURE2D(_HolesTex);
			SAMPLER(sampler_Linear_Clamp_Aniso8);
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment TVE_ALPHA_CLIP
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap forwardadd
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			AttributesMesh ApplyMeshModification( AttributesMesh inputMesh )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = inputMesh.positionOS.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				inputMesh.positionOS.xz = sampleCoords* _TerrainHeightmapScale.xz;
				inputMesh.positionOS.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					inputMesh.normalOS = float3(0, 1, 0);
				#else
					inputMesh.normalOS = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				inputMesh.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return inputMesh;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout AlphaSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// refraction ShadowCaster
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                    #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);

	            

	            
                #if ASE_SRP_VERSION >=140008
                #ifdef DECAL_NORMAL_BLENDING
					normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normalTS, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;

                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                     }
                    #endif

                    GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
                #else
					GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;
        
                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                    }
                    #endif
                #endif
                #endif
               

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

                #if defined(DEBUG_DISPLAY)
                    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                    {
                        surfaceData.metallic = 0;
                    }
                    ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
                #endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(AlphaSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification(inputMesh);
				float3 VertexPosition3588_g79798 = inputMesh.positionOS;
				float temp_output_84_0_g79811 = _LayerVertexValue;
				float temp_output_19_0_g79815 = TVE_VertexUsage[(int)temp_output_84_0_g79811];
				float4 temp_output_94_19_g79811 = TVE_VertexCoords;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag7344_g79798 = ase_worldPos;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV97_g79811 = ( (temp_output_94_19_g79811).zw + ( (temp_output_94_19_g79811).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode50_g79811 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g79811,temp_output_84_0_g79811, 0.0 );
				float4 temp_output_17_0_g79815 = tex2DArrayNode50_g79811;
				float4 temp_output_111_19_g79811 = TVE_VertexParams;
				float4 temp_output_3_0_g79815 = temp_output_111_19_g79811;
				float4 ifLocalVar18_g79815 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79815 >= 0.5 )
				ifLocalVar18_g79815 = temp_output_17_0_g79815;
				else
				ifLocalVar18_g79815 = temp_output_3_0_g79815;
				float4 lerpResult22_g79815 = lerp( temp_output_3_0_g79815 , temp_output_17_0_g79815 , temp_output_19_0_g79815);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79815 = lerpResult22_g79815;
				#else
				float4 staticSwitch24_g79815 = ifLocalVar18_g79815;
				#endif
				half4 Global_Vertex_Params4173_g79798 = staticSwitch24_g79815;
				float4 break322_g79802 = Global_Vertex_Params4173_g79798;
				half Global_VertexOffset7327_g79798 = break322_g79802.z;
				float3 appendResult7336_g79798 = (float3(0.0 , ( Global_VertexOffset7327_g79798 * _GlobalHeight ) , 0.0));
				half3 Vertex_Offset7335_g79798 = appendResult7336_g79798;
				float3 Vertex_Output890_g79798 = ( VertexPosition3588_g79798 + Vertex_Offset7335_g79798 );
				
				float4 appendResult7007_g79798 = (float4(cross( inputMesh.normalOS , float3(0,0,1) ) , -1.0));
				half4 Vertex_Tangents7390_g79798 = appendResult7007_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord2.xyz = vertexToFrag7344_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord1.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord1.zw = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord2.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Vertex_Output890_g79798;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS = Vertex_Tangents7390_g79798;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif

						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
			UNITY_SETUP_INSTANCE_ID(packedInput);

				float3 positionRWS = packedInput.positionRWS.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				AlphaSurfaceDescription surfaceDescription = (AlphaSurfaceDescription)0;
				float localCustomAlphaClip19_g83341 = ( 0.0 );
				float2 Terrain_Control_UV7873_g83242 = packedInput.ase_texcoord1.xy;
				half Terrain_Holes7437_g83242 = SAMPLE_TEXTURE2D( _HolesTex, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 ).r;
				half Terrain_Holes7159_g79798 = Terrain_Holes7437_g83242;
				float temp_output_84_0_g79816 = _LayerExtrasValue;
				float temp_output_19_0_g79820 = TVE_ExtrasUsage[(int)temp_output_84_0_g79816];
				float4 temp_output_93_19_g79816 = TVE_ExtrasCoords;
				float3 vertexToFrag7344_g79798 = packedInput.ase_texcoord2.xyz;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV96_g79816 = ( (temp_output_93_19_g79816).zw + ( (temp_output_93_19_g79816).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode48_g79816 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g79816,temp_output_84_0_g79816, 0.0 );
				float4 temp_output_17_0_g79820 = tex2DArrayNode48_g79816;
				float4 temp_output_94_85_g79816 = TVE_ExtrasParams;
				float4 temp_output_3_0_g79820 = temp_output_94_85_g79816;
				float4 ifLocalVar18_g79820 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79820 >= 0.5 )
				ifLocalVar18_g79820 = temp_output_17_0_g79820;
				else
				ifLocalVar18_g79820 = temp_output_3_0_g79820;
				float4 lerpResult22_g79820 = lerp( temp_output_3_0_g79820 , temp_output_17_0_g79820 , temp_output_19_0_g79820);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79820 = lerpResult22_g79820;
				#else
				float4 staticSwitch24_g79820 = ifLocalVar18_g79820;
				#endif
				half4 Global_Extras_Params5440_g79798 = staticSwitch24_g79820;
				float4 break456_g79805 = Global_Extras_Params5440_g79798;
				half Global_Extras_Alpha1033_g79798 = saturate( break456_g79805.w );
				float lerpResult7479_g79798 = lerp( 1.0 , Global_Extras_Alpha1033_g79798 , _GlobalAlpha);
				half Alpha_Global7481_g79798 = lerpResult7479_g79798;
				half AlphaTreshold2132_g79798 = _AlphaClipValue;
				float temp_output_3_0_g83341 = ( ( Terrain_Holes7159_g79798 * Alpha_Global7481_g79798 ) - AlphaTreshold2132_g79798 );
				float Alpha19_g83341 = temp_output_3_0_g83341;
				float temp_output_15_0_g83341 = 0.01;
				float Treshold19_g83341 = temp_output_15_0_g83341;
				{
				#if defined (TVE_ALPHA_CLIP) || defined (TVE_ALPHA_FADE) || defined (TVE_ALPHA_GLOBAL)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#else
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#endif
				}
				
				surfaceDescription.Alpha = Alpha19_g83341;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				float bias = max(abs(ddx(posInput.deviceDepth)), abs(ddy(posInput.deviceDepth))) * _SlopeScaleDepthBias;
				outputDepth += bias;
				#endif

				#ifdef WRITE_MSAA_DEPTH
					depthColor = packedInput.vmesh.positionCS.z;
					depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
				#endif

				#if defined(WRITE_NORMAL_BUFFER)
				EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
				#endif

                #if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				DecalPrepassData decalPrepassData;
				decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
				decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
				EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
                #endif
			}
			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off

			HLSLPROGRAM
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140011
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma editor_sync_compilation
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
		    #define SCENESELECTIONPASS 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MaskMax8;
			half4 _Coords7;
			half4 _MaskMax6;
			half4 _MaskMin6;
			half4 _Coords6;
			half4 _MaskMax5;
			half4 _MaskMin5;
			half4 _Coords5;
			half4 _MaskMax4;
			half4 _MaskMin4;
			half4 _MaskMin7;
			half4 _Coords4;
			half4 _MaskMin3;
			half4 _Coords3;
			half4 _MaskMax2;
			half4 _MaskMin2;
			half4 _Coords2;
			half4 _MaskMax1;
			half4 _MaskMin1;
			half4 _Coords1;
			half4 _MaskMax16;
			half4 _MaskMax3;
			half4 _MaskMax7;
			half4 _Coords8;
			half4 _MaskMin8;
			half4 _MaskMin15;
			half4 _Coords15;
			half4 _MaskMax14;
			half4 _MaskMin14;
			half4 _Coords14;
			half4 _MaskMax13;
			half4 _MaskMin13;
			half4 _Coords13;
			half4 _MaskMax12;
			half4 _MaskMin12;
			half4 _Coords12;
			half4 _MaskMax11;
			half4 _MaskMin11;
			half4 _Coords11;
			half4 _MaskMax10;
			half4 _MaskMin10;
			half4 _Coords10;
			half4 _MaskMax9;
			half4 _MaskMin9;
			half4 _Coords9;
			half4 _MaskMin16;
			half4 _TerrainColor;
			half4 _MaskMax15;
			half4 _Coords16;
			half4 _Params5;
			half4 _Params2;
			half4 _Params3;
			half4 _Params4;
			half4 _Params6;
			half4 _Params7;
			half4 _Params8;
			half4 _Params1;
			half4 _Params9;
			half4 _Params11;
			half4 _Params12;
			half4 _Params13;
			half4 _Params14;
			half4 _Params15;
			half4 _Params16;
			half4 _Params10;
			half4 _Specular16;
			half4 _EmissiveColor;
			half4 _Specular7;
			half4 _Specular3;
			half4 _Specular4;
			half4 _Specular5;
			half4 _Specular6;
			half4 _Specular15;
			half4 _Specular8;
			half4 _Specular2;
			half4 _Specular9;
			half4 _Specular11;
			half4 _Specular12;
			half4 _Specular13;
			half4 _Specular14;
			half4 _Specular10;
			half4 _Specular1;
			half _EmissivePhaseValue;
			half _GlobalEmissive;
			half _TerrainSmoothnessValue;
			float _emissive_intensity_value;
			half _EmissiveAlbedoMode;
			half _TerrainOcclusionValue;
			half _EmissiveExposureValue;
			half _GlobalColors;
			half _OverlayProjectionValue;
			half _TerrainNormalValue;
			half _ColorsIntensityValue;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _TerrainHeightBlendValue;
			half _GlobalWetness;
			half _LayerColorsValue;
			half _CategoryGlobals;
			half _GlobalHeight;
			half _CategoryEmissive;
			half _CategoryMotion;
			half _EmissiveIntensityValue;
			half _EmissiveIntensityMode;
			half _EmissiveFlagMode;
			half _IsVersion;
			half _IsTerrainShader;
			half _CategoryRender;
			half _MessageTerrainEmissive;
			half _MessageTerrainColors;
			half _CategoryTerrain;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _IsCustomShader;
			half _IsShared;
			half _IsCollected;
			half _IsIdentifier;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceGlobalOptions;
			half _SpaceGlobalLocals;
			half _SpaceGlobalLayers;
			half _CategoryLayers;
			half _GlobalAlpha;
			half _TerrainLayersMode;
			half _TerrainBlendMode;
			half _LayerVertexValue;
			half _RenderClip;
			half _LayerSampleMode16;
			half _LayerSampleMode15;
			half _LayerSampleMode14;
			half _LayerSampleMode13;
			half _LayerSampleMode12;
			half _LayerSampleMode11;
			half _LayerSampleMode10;
			half _LayerSampleMode9;
			half _LayerSampleMode8;
			half _LayerSampleMode7;
			half _LayerSampleMode6;
			half _LayerSampleMode5;
			half _LayerSampleMode1;
			half _LayerSampleMode4;
			half _LayerSampleMode3;
			half _LayerSampleMode2;
			half _CategoryInputs;
			half _TerrainTexMode;
			half _RenderMode;
			half _RenderDecals;
			half _EmissiveMode;
			half _MessageTerrainMasks;
			half _AlphaClipValue;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(sampler_Linear_Clamp);
			half4 TVE_VertexParams;
			TEXTURE2D(_HolesTex);
			SAMPLER(sampler_Linear_Clamp_Aniso8);
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment TVE_ALPHA_CLIP
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap forwardadd
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			AttributesMesh ApplyMeshModification( AttributesMesh inputMesh )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = inputMesh.positionOS.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				inputMesh.positionOS.xz = sampleCoords* _TerrainHeightmapScale.xz;
				inputMesh.positionOS.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					inputMesh.normalOS = float3(0, 1, 0);
				#else
					inputMesh.normalOS = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				inputMesh.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return inputMesh;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SceneSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				//refraction SceneSelectionPass
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
                    float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);

	            

	            
                #if ASE_SRP_VERSION >=140008
                #ifdef DECAL_NORMAL_BLENDING
					normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normalTS, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;

                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                     }
                    #endif

                    GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
                #else
					GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;
        
                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                    }
                    #endif
                #endif
                #endif
               

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

                #if defined(DEBUG_DISPLAY)
                    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                   {
                        surfaceData.metallic = 0;
                   }
                     ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
                #endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(SceneSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification(inputMesh);
				float3 VertexPosition3588_g79798 = inputMesh.positionOS;
				float temp_output_84_0_g79811 = _LayerVertexValue;
				float temp_output_19_0_g79815 = TVE_VertexUsage[(int)temp_output_84_0_g79811];
				float4 temp_output_94_19_g79811 = TVE_VertexCoords;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag7344_g79798 = ase_worldPos;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV97_g79811 = ( (temp_output_94_19_g79811).zw + ( (temp_output_94_19_g79811).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode50_g79811 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g79811,temp_output_84_0_g79811, 0.0 );
				float4 temp_output_17_0_g79815 = tex2DArrayNode50_g79811;
				float4 temp_output_111_19_g79811 = TVE_VertexParams;
				float4 temp_output_3_0_g79815 = temp_output_111_19_g79811;
				float4 ifLocalVar18_g79815 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79815 >= 0.5 )
				ifLocalVar18_g79815 = temp_output_17_0_g79815;
				else
				ifLocalVar18_g79815 = temp_output_3_0_g79815;
				float4 lerpResult22_g79815 = lerp( temp_output_3_0_g79815 , temp_output_17_0_g79815 , temp_output_19_0_g79815);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79815 = lerpResult22_g79815;
				#else
				float4 staticSwitch24_g79815 = ifLocalVar18_g79815;
				#endif
				half4 Global_Vertex_Params4173_g79798 = staticSwitch24_g79815;
				float4 break322_g79802 = Global_Vertex_Params4173_g79798;
				half Global_VertexOffset7327_g79798 = break322_g79802.z;
				float3 appendResult7336_g79798 = (float3(0.0 , ( Global_VertexOffset7327_g79798 * _GlobalHeight ) , 0.0));
				half3 Vertex_Offset7335_g79798 = appendResult7336_g79798;
				float3 Vertex_Output890_g79798 = ( VertexPosition3588_g79798 + Vertex_Offset7335_g79798 );
				
				float4 appendResult7007_g79798 = (float4(cross( inputMesh.normalOS , float3(0,0,1) ) , -1.0));
				half4 Vertex_Tangents7390_g79798 = appendResult7007_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord2.xyz = vertexToFrag7344_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord1.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord1.zw = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord2.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Vertex_Output890_g79798;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS = Vertex_Tangents7390_g79798;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						, out float4 outColor : SV_Target0
						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.positionRWS.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SceneSurfaceDescription surfaceDescription = (SceneSurfaceDescription)0;
				float localCustomAlphaClip19_g83341 = ( 0.0 );
				float2 Terrain_Control_UV7873_g83242 = packedInput.ase_texcoord1.xy;
				half Terrain_Holes7437_g83242 = SAMPLE_TEXTURE2D( _HolesTex, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 ).r;
				half Terrain_Holes7159_g79798 = Terrain_Holes7437_g83242;
				float temp_output_84_0_g79816 = _LayerExtrasValue;
				float temp_output_19_0_g79820 = TVE_ExtrasUsage[(int)temp_output_84_0_g79816];
				float4 temp_output_93_19_g79816 = TVE_ExtrasCoords;
				float3 vertexToFrag7344_g79798 = packedInput.ase_texcoord2.xyz;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV96_g79816 = ( (temp_output_93_19_g79816).zw + ( (temp_output_93_19_g79816).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode48_g79816 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g79816,temp_output_84_0_g79816, 0.0 );
				float4 temp_output_17_0_g79820 = tex2DArrayNode48_g79816;
				float4 temp_output_94_85_g79816 = TVE_ExtrasParams;
				float4 temp_output_3_0_g79820 = temp_output_94_85_g79816;
				float4 ifLocalVar18_g79820 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79820 >= 0.5 )
				ifLocalVar18_g79820 = temp_output_17_0_g79820;
				else
				ifLocalVar18_g79820 = temp_output_3_0_g79820;
				float4 lerpResult22_g79820 = lerp( temp_output_3_0_g79820 , temp_output_17_0_g79820 , temp_output_19_0_g79820);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79820 = lerpResult22_g79820;
				#else
				float4 staticSwitch24_g79820 = ifLocalVar18_g79820;
				#endif
				half4 Global_Extras_Params5440_g79798 = staticSwitch24_g79820;
				float4 break456_g79805 = Global_Extras_Params5440_g79798;
				half Global_Extras_Alpha1033_g79798 = saturate( break456_g79805.w );
				float lerpResult7479_g79798 = lerp( 1.0 , Global_Extras_Alpha1033_g79798 , _GlobalAlpha);
				half Alpha_Global7481_g79798 = lerpResult7479_g79798;
				half AlphaTreshold2132_g79798 = _AlphaClipValue;
				float temp_output_3_0_g83341 = ( ( Terrain_Holes7159_g79798 * Alpha_Global7481_g79798 ) - AlphaTreshold2132_g79798 );
				float Alpha19_g83341 = temp_output_3_0_g83341;
				float temp_output_15_0_g83341 = 0.01;
				float Treshold19_g83341 = temp_output_15_0_g83341;
				{
				#if defined (TVE_ALPHA_CLIP) || defined (TVE_ALPHA_FADE) || defined (TVE_ALPHA_GLOBAL)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#else
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#endif
				}
				
				surfaceDescription.Alpha = Alpha19_g83341;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
			}
			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			Cull [_CullMode]
			ZWrite On

			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
				Comp Always
				Pass Replace
			}


			HLSLPROGRAM
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140011
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
            #pragma multi_compile _ WRITE_DECAL_BUFFER

			#pragma vertex Vert
			#pragma fragment Frag

            #define SHADERPASS SHADERPASS_DEPTH_ONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MaskMax8;
			half4 _Coords7;
			half4 _MaskMax6;
			half4 _MaskMin6;
			half4 _Coords6;
			half4 _MaskMax5;
			half4 _MaskMin5;
			half4 _Coords5;
			half4 _MaskMax4;
			half4 _MaskMin4;
			half4 _MaskMin7;
			half4 _Coords4;
			half4 _MaskMin3;
			half4 _Coords3;
			half4 _MaskMax2;
			half4 _MaskMin2;
			half4 _Coords2;
			half4 _MaskMax1;
			half4 _MaskMin1;
			half4 _Coords1;
			half4 _MaskMax16;
			half4 _MaskMax3;
			half4 _MaskMax7;
			half4 _Coords8;
			half4 _MaskMin8;
			half4 _MaskMin15;
			half4 _Coords15;
			half4 _MaskMax14;
			half4 _MaskMin14;
			half4 _Coords14;
			half4 _MaskMax13;
			half4 _MaskMin13;
			half4 _Coords13;
			half4 _MaskMax12;
			half4 _MaskMin12;
			half4 _Coords12;
			half4 _MaskMax11;
			half4 _MaskMin11;
			half4 _Coords11;
			half4 _MaskMax10;
			half4 _MaskMin10;
			half4 _Coords10;
			half4 _MaskMax9;
			half4 _MaskMin9;
			half4 _Coords9;
			half4 _MaskMin16;
			half4 _TerrainColor;
			half4 _MaskMax15;
			half4 _Coords16;
			half4 _Params5;
			half4 _Params2;
			half4 _Params3;
			half4 _Params4;
			half4 _Params6;
			half4 _Params7;
			half4 _Params8;
			half4 _Params1;
			half4 _Params9;
			half4 _Params11;
			half4 _Params12;
			half4 _Params13;
			half4 _Params14;
			half4 _Params15;
			half4 _Params16;
			half4 _Params10;
			half4 _Specular16;
			half4 _EmissiveColor;
			half4 _Specular7;
			half4 _Specular3;
			half4 _Specular4;
			half4 _Specular5;
			half4 _Specular6;
			half4 _Specular15;
			half4 _Specular8;
			half4 _Specular2;
			half4 _Specular9;
			half4 _Specular11;
			half4 _Specular12;
			half4 _Specular13;
			half4 _Specular14;
			half4 _Specular10;
			half4 _Specular1;
			half _EmissivePhaseValue;
			half _GlobalEmissive;
			half _TerrainSmoothnessValue;
			float _emissive_intensity_value;
			half _EmissiveAlbedoMode;
			half _TerrainOcclusionValue;
			half _EmissiveExposureValue;
			half _GlobalColors;
			half _OverlayProjectionValue;
			half _TerrainNormalValue;
			half _ColorsIntensityValue;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _TerrainHeightBlendValue;
			half _GlobalWetness;
			half _LayerColorsValue;
			half _CategoryGlobals;
			half _GlobalHeight;
			half _CategoryEmissive;
			half _CategoryMotion;
			half _EmissiveIntensityValue;
			half _EmissiveIntensityMode;
			half _EmissiveFlagMode;
			half _IsVersion;
			half _IsTerrainShader;
			half _CategoryRender;
			half _MessageTerrainEmissive;
			half _MessageTerrainColors;
			half _CategoryTerrain;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _IsCustomShader;
			half _IsShared;
			half _IsCollected;
			half _IsIdentifier;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceGlobalOptions;
			half _SpaceGlobalLocals;
			half _SpaceGlobalLayers;
			half _CategoryLayers;
			half _GlobalAlpha;
			half _TerrainLayersMode;
			half _TerrainBlendMode;
			half _LayerVertexValue;
			half _RenderClip;
			half _LayerSampleMode16;
			half _LayerSampleMode15;
			half _LayerSampleMode14;
			half _LayerSampleMode13;
			half _LayerSampleMode12;
			half _LayerSampleMode11;
			half _LayerSampleMode10;
			half _LayerSampleMode9;
			half _LayerSampleMode8;
			half _LayerSampleMode7;
			half _LayerSampleMode6;
			half _LayerSampleMode5;
			half _LayerSampleMode1;
			half _LayerSampleMode4;
			half _LayerSampleMode3;
			half _LayerSampleMode2;
			half _CategoryInputs;
			half _TerrainTexMode;
			half _RenderMode;
			half _RenderDecals;
			half _EmissiveMode;
			half _MessageTerrainMasks;
			half _AlphaClipValue;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(sampler_Linear_Clamp);
			half4 TVE_VertexParams;
			TEXTURE2D(_ControlTex1);
			SAMPLER(sampler_Linear_Clamp_Aniso8);
			TEXTURE2D(_ControlTex2);
			TEXTURE2D(_ControlTex3);
			TEXTURE2D(_ControlTex4);
			TEXTURE2D(_MaskTex1);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			TEXTURE2D(_MaskTex2);
			TEXTURE2D(_MaskTex3);
			TEXTURE2D(_MaskTex4);
			TEXTURE2D(_MaskTex5);
			TEXTURE2D(_MaskTex6);
			TEXTURE2D(_MaskTex7);
			TEXTURE2D(_MaskTex8);
			TEXTURE2D(_MaskTex9);
			TEXTURE2D(_MaskTex10);
			TEXTURE2D(_MaskTex11);
			TEXTURE2D(_MaskTex12);
			TEXTURE2D(_MaskTex13);
			TEXTURE2D(_MaskTex14);
			TEXTURE2D(_MaskTex15);
			TEXTURE2D(_MaskTex16);
			TEXTURE2D(_NormalTex1);
			TEXTURE2D(_NormalTex2);
			TEXTURE2D(_NormalTex3);
			TEXTURE2D(_NormalTex4);
			TEXTURE2D(_NormalTex5);
			TEXTURE2D(_NormalTex6);
			TEXTURE2D(_NormalTex7);
			TEXTURE2D(_NormalTex8);
			TEXTURE2D(_NormalTex9);
			TEXTURE2D(_NormalTex10);
			TEXTURE2D(_NormalTex11);
			TEXTURE2D(_NormalTex12);
			TEXTURE2D(_NormalTex13);
			TEXTURE2D(_NormalTex14);
			TEXTURE2D(_NormalTex15);
			TEXTURE2D(_NormalTex16);
			half TVE_OverlayNormalValue;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			TEXTURE2D(_AlbedoTex1);
			TEXTURE2D(_AlbedoTex2);
			TEXTURE2D(_AlbedoTex3);
			TEXTURE2D(_AlbedoTex4);
			TEXTURE2D(_AlbedoTex5);
			TEXTURE2D(_AlbedoTex6);
			TEXTURE2D(_AlbedoTex7);
			TEXTURE2D(_AlbedoTex8);
			TEXTURE2D(_AlbedoTex9);
			TEXTURE2D(_AlbedoTex10);
			TEXTURE2D(_AlbedoTex11);
			TEXTURE2D(_AlbedoTex12);
			TEXTURE2D(_AlbedoTex13);
			TEXTURE2D(_AlbedoTex14);
			TEXTURE2D(_AlbedoTex15);
			TEXTURE2D(_AlbedoTex16);
			half TVE_WetnessNormalValue;
			half TVE_OverlaySmoothness;
			TEXTURE2D(_HolesTex);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#pragma shader_feature_local_fragment TVE_ALPHA_CLIP
			#pragma shader_feature_local_fragment TVE_PACKED_TEX
			#pragma shader_feature_local_fragment TVE_TERRAIN_04 TVE_TERRAIN_08 TVE_TERRAIN_12 TVE_TERRAIN_16
			#pragma shader_feature_local_fragment TVE_HEIGHT_BLEND
			#pragma shader_feature_local_fragment TVE_SAMPLE_01_PLANAR_2D TVE_SAMPLE_01_PLANAR_3D TVE_SAMPLE_01_STOCHASTIC_2D TVE_SAMPLE_01_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_02_PLANAR_2D TVE_SAMPLE_02_PLANAR_3D TVE_SAMPLE_02_STOCHASTIC_2D TVE_SAMPLE_02_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_03_PLANAR_2D TVE_SAMPLE_03_PLANAR_3D TVE_SAMPLE_03_STOCHASTIC_2D TVE_SAMPLE_03_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_04_PLANAR_2D TVE_SAMPLE_04_PLANAR_3D TVE_SAMPLE_04_STOCHASTIC_2D TVE_SAMPLE_04_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_05_PLANAR_2D TVE_SAMPLE_05_PLANAR_3D TVE_SAMPLE_05_STOCHASTIC_2D TVE_SAMPLE_05_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_06_PLANAR_2D TVE_SAMPLE_06_PLANAR_3D TVE_SAMPLE_06_STOCHASTIC_2D TVE_SAMPLE_06_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_07_PLANAR_2D TVE_SAMPLE_07_PLANAR_3D TVE_SAMPLE_07_STOCHASTIC_2D TVE_SAMPLE_07_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_08_PLANAR_2D TVE_SAMPLE_08_PLANAR_3D TVE_SAMPLE_08_STOCHASTIC_2D TVE_SAMPLE_08_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_09_PLANAR_2D TVE_SAMPLE_09_PLANAR_3D TVE_SAMPLE_09_STOCHASTIC_2D TVE_SAMPLE_09_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_10_PLANAR_2D TVE_SAMPLE_10_PLANAR_3D TVE_SAMPLE_10_STOCHASTIC_2D TVE_SAMPLE_10_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_11_PLANAR_2D TVE_SAMPLE_11_PLANAR_3D TVE_SAMPLE_11_STOCHASTIC_2D TVE_SAMPLE_11_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_12_PLANAR_2D TVE_SAMPLE_12_PLANAR_3D TVE_SAMPLE_12_STOCHASTIC_2D TVE_SAMPLE_12_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_13_PLANAR_2D TVE_SAMPLE_13_PLANAR_3D TVE_SAMPLE_13_STOCHASTIC_2D TVE_SAMPLE_13_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_14_PLANAR_2D TVE_SAMPLE_14_PLANAR_3D TVE_SAMPLE_14_STOCHASTIC_2D TVE_SAMPLE_14_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_15_PLANAR_2D TVE_SAMPLE_15_PLANAR_3D TVE_SAMPLE_15_STOCHASTIC_2D TVE_SAMPLE_15_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_16_PLANAR_2D TVE_SAMPLE_16_PLANAR_3D TVE_SAMPLE_16_STOCHASTIC_2D TVE_SAMPLE_16_STOCHASTIC_3D
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap forwardadd
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			void ComputeWorldCoords( half4 Coords, half3 WorldPosition, out half2 ZX, out half2 ZY, out half2 XY )
			{
				ZX = WorldPosition.xz * Coords.xy + Coords.zw;
				ZY = WorldPosition.zy * Coords.xy + Coords.zw; 
				XY = WorldPosition.xy * Coords.xy + Coords.zw;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half4 tex = SAMPLE_TEXTURE2D( Texture, Sampler, ZX);
				return tex;
			}
			
			void ComputeTriplanarWeights( half3 WorldNormal, out half T1, out half T2, out half T3 )
			{
				half3 powNormal = abs( WorldNormal.xyz );
				half3 weights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.000001 );
				weights /= ( weights.x + weights.y + weights.z ).xxx;
				T1 = weights.y;
				T2 = weights.x;
				T3 = weights.z;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition, half3 WorldNormal )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half T1, T2, T3;
				ComputeTriplanarWeights(WorldNormal, T1, T2, T3);
				half4 tex1 = SAMPLE_TEXTURE2D( Texture, Sampler, ZX);
				half4 tex2 = SAMPLE_TEXTURE2D( Texture, Sampler, ZY);
				half4 tex3 = SAMPLE_TEXTURE2D( Texture, Sampler, XY);
				return tex1 * T1 + tex2 * T2 + tex3 * T3;
			}
			
			void ComputeStochasticCoords( float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float W1, out float W2, out float W3 )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					W1 = temp.z;
					W2 = temp.y;
					W3 = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					W1 = -temp.z;
					W2 = 1.0 - temp.y;
					W3 = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex1 ) ) * 43758.5453 );
				UV2 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex2 ) ) * 43758.5453 );
				UV3 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex3 ) ) * 43758.5453 );
				return;
			}
			
			float4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half2 UV1, UV2, UV3;
				half W1, W2, W3;
				ComputeStochasticCoords(ZX, UV1, UV2, UV3, W1, W2, W3 );
				half4 tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZX), ddy(ZX));
				half4 tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZX), ddy(ZX));
				half4 tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZX), ddy(ZX));
				return tex1 * W1 + tex2 * W2 + tex3 * W3;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition, half3 WorldNormal )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half2 UV1, UV2, UV3;
				half W1, W2, W3;
				half4 tex1, tex2, tex3;
				ComputeStochasticCoords(ZX, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZX), ddy(ZX));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZX), ddy(ZX));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZX), ddy(ZX));
				half4 texZX = tex1 * W1 + tex2 * W2 + tex3 * W3;
				ComputeStochasticCoords(ZY, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZY), ddy(ZY));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZY), ddy(ZY));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZY), ddy(ZY));
				half4 texZY = tex1 * W1 + tex2 * W2 + tex3 * W3;
				ComputeStochasticCoords(XY, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(XY), ddy(XY));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(XY), ddy(XY));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(XY), ddy(XY));
				half4 texXY = tex1 * W1 + tex2 * W2 + tex3 * W3;
				half T1, T2, T3;
				ComputeTriplanarWeights(WorldNormal, T1, T2, T3);
				return texZX * T1 + texZY * T2 + texXY * T3;
			}
			
			AttributesMesh ApplyMeshModification( AttributesMesh inputMesh )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = inputMesh.positionOS.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				inputMesh.positionOS.xz = sampleCoords* _TerrainHeightmapScale.xz;
				inputMesh.positionOS.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					inputMesh.normalOS = float3(0, 1, 0);
				#else
					inputMesh.normalOS = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				inputMesh.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return inputMesh;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SmoothSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
				    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				    float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;

	            

	            
                #if ASE_SRP_VERSION >=140008
                #ifdef DECAL_NORMAL_BLENDING
					normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normalTS, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;

                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                     }
                    #endif

                    GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
                #else
					GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;

                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                    }
                    #endif
                #endif
                #endif
               

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

                #if defined(DEBUG_DISPLAY)
                    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                    {
                        surfaceData.metallic = 0;
                    }
                     ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
                #endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(SmoothSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalPrepassBuffer.hlsl"
			#endif

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification(inputMesh);
				float3 VertexPosition3588_g79798 = inputMesh.positionOS;
				float temp_output_84_0_g79811 = _LayerVertexValue;
				float temp_output_19_0_g79815 = TVE_VertexUsage[(int)temp_output_84_0_g79811];
				float4 temp_output_94_19_g79811 = TVE_VertexCoords;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag7344_g79798 = ase_worldPos;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV97_g79811 = ( (temp_output_94_19_g79811).zw + ( (temp_output_94_19_g79811).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode50_g79811 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g79811,temp_output_84_0_g79811, 0.0 );
				float4 temp_output_17_0_g79815 = tex2DArrayNode50_g79811;
				float4 temp_output_111_19_g79811 = TVE_VertexParams;
				float4 temp_output_3_0_g79815 = temp_output_111_19_g79811;
				float4 ifLocalVar18_g79815 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79815 >= 0.5 )
				ifLocalVar18_g79815 = temp_output_17_0_g79815;
				else
				ifLocalVar18_g79815 = temp_output_3_0_g79815;
				float4 lerpResult22_g79815 = lerp( temp_output_3_0_g79815 , temp_output_17_0_g79815 , temp_output_19_0_g79815);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79815 = lerpResult22_g79815;
				#else
				float4 staticSwitch24_g79815 = ifLocalVar18_g79815;
				#endif
				half4 Global_Vertex_Params4173_g79798 = staticSwitch24_g79815;
				float4 break322_g79802 = Global_Vertex_Params4173_g79798;
				half Global_VertexOffset7327_g79798 = break322_g79802.z;
				float3 appendResult7336_g79798 = (float3(0.0 , ( Global_VertexOffset7327_g79798 * _GlobalHeight ) , 0.0));
				half3 Vertex_Offset7335_g79798 = appendResult7336_g79798;
				float3 Vertex_Output890_g79798 = ( VertexPosition3588_g79798 + Vertex_Offset7335_g79798 );
				
				float4 appendResult7007_g79798 = (float4(cross( inputMesh.normalOS , float3(0,0,1) ) , -1.0));
				half4 Vertex_Tangents7390_g79798 = appendResult7007_g79798;
				
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.tangentOS.xyz);
				float ase_vertexTangentSign = inputMesh.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				outputPackedVaryingsMeshToPS.ase_texcoord3.xyz = ase_worldBitangent;
				outputPackedVaryingsMeshToPS.ase_texcoord5.xyz = vertexToFrag7344_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord4.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord3.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord4.zw = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord5.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Vertex_Output890_g79798;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS = Vertex_Tangents7390_g79798;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif

						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
			UNITY_SETUP_INSTANCE_ID(packedInput);

				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SmoothSurfaceDescription surfaceDescription = (SmoothSurfaceDescription)0;
				float3 ase_worldBitangent = packedInput.ase_texcoord3.xyz;
				float3x3 ase_worldToTangent = float3x3(tangentWS.xyz,ase_worldBitangent,normalWS);
				float localHeightBasedBlending7362_g83242 = ( 0.0 );
				float2 Terrain_Control_UV7873_g83242 = packedInput.ase_texcoord4.xy;
				half4 Terrain_Control_047365_g83242 = SAMPLE_TEXTURE2D( _ControlTex1, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_047362_g83242 = Terrain_Control_047365_g83242;
				half4 Terrain_Control_087366_g83242 = SAMPLE_TEXTURE2D( _ControlTex2, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_087362_g83242 = Terrain_Control_087366_g83242;
				half4 Terrain_Control_127712_g83242 = SAMPLE_TEXTURE2D( _ControlTex3, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_127362_g83242 = Terrain_Control_127712_g83242;
				half4 Terrain_Control_167711_g83242 = SAMPLE_TEXTURE2D( _ControlTex4, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_167362_g83242 = Terrain_Control_167711_g83242;
				TEXTURE2D(Texture238_g83299) = _MaskTex1;
				SamplerState Sampler238_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_016785_g83242 = _Coords1;
				float4 temp_output_37_0_g83299 = Input_Coords_016785_g83242;
				half4 Coords238_g83299 = temp_output_37_0_g83299;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				half3 WorldPosition238_g83299 = ase_worldPos;
				half4 localSamplePlanar2D238_g83299 = SamplePlanar2D( Texture238_g83299 , Sampler238_g83299 , Coords238_g83299 , WorldPosition238_g83299 );
				TEXTURE2D(Texture246_g83299) = _MaskTex1;
				SamplerState Sampler246_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83299 = temp_output_37_0_g83299;
				half3 WorldPosition246_g83299 = ase_worldPos;
				half3 WorldNormal246_g83299 = normalWS;
				half4 localSamplePlanar3D246_g83299 = SamplePlanar3D( Texture246_g83299 , Sampler246_g83299 , Coords246_g83299 , WorldPosition246_g83299 , WorldNormal246_g83299 );
				TEXTURE2D(Texture234_g83299) = _MaskTex1;
				SamplerState Sampler234_g83299 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83299 = temp_output_37_0_g83299;
				float3 WorldPosition234_g83299 = ase_worldPos;
				float4 localSampleStochastic2D234_g83299 = SampleStochastic2D( Texture234_g83299 , Sampler234_g83299 , Coords234_g83299 , WorldPosition234_g83299 );
				TEXTURE2D(Texture263_g83299) = _MaskTex1;
				SamplerState Sampler263_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83299 = temp_output_37_0_g83299;
				half3 WorldPosition263_g83299 = ase_worldPos;
				half3 WorldNormal263_g83299 = normalWS;
				half4 localSampleStochastic3D263_g83299 = SampleStochastic3D( Texture263_g83299 , Sampler263_g83299 , Coords263_g83299 , WorldPosition263_g83299 , WorldNormal263_g83299 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8639_g83242 = localSamplePlanar2D238_g83299;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8639_g83242 = localSamplePlanar3D246_g83299;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8639_g83242 = localSampleStochastic2D234_g83299;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8639_g83242 = localSampleStochastic3D263_g83299;
				#else
				float4 staticSwitch8639_g83242 = localSamplePlanar2D238_g83299;
				#endif
				float4 temp_output_7_0_g83248 = _MaskMin1;
				float4 temp_output_10_0_g83248 = ( _MaskMax1 - temp_output_7_0_g83248 );
				float4 temp_output_6970_0_g83242 = saturate( ( ( staticSwitch8639_g83242 - temp_output_7_0_g83248 ) / ( temp_output_10_0_g83248 + 0.0001 ) ) );
				half4 Masks_015_g83256 = temp_output_6970_0_g83242;
				TEXTURE2D(Texture238_g83300) = _MaskTex2;
				SamplerState Sampler238_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_026787_g83242 = _Coords2;
				float4 temp_output_37_0_g83300 = Input_Coords_026787_g83242;
				half4 Coords238_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition238_g83300 = ase_worldPos;
				half4 localSamplePlanar2D238_g83300 = SamplePlanar2D( Texture238_g83300 , Sampler238_g83300 , Coords238_g83300 , WorldPosition238_g83300 );
				TEXTURE2D(Texture246_g83300) = _MaskTex2;
				SamplerState Sampler246_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition246_g83300 = ase_worldPos;
				half3 WorldNormal246_g83300 = normalWS;
				half4 localSamplePlanar3D246_g83300 = SamplePlanar3D( Texture246_g83300 , Sampler246_g83300 , Coords246_g83300 , WorldPosition246_g83300 , WorldNormal246_g83300 );
				TEXTURE2D(Texture234_g83300) = _MaskTex2;
				SamplerState Sampler234_g83300 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83300 = temp_output_37_0_g83300;
				float3 WorldPosition234_g83300 = ase_worldPos;
				float4 localSampleStochastic2D234_g83300 = SampleStochastic2D( Texture234_g83300 , Sampler234_g83300 , Coords234_g83300 , WorldPosition234_g83300 );
				TEXTURE2D(Texture263_g83300) = _MaskTex2;
				SamplerState Sampler263_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition263_g83300 = ase_worldPos;
				half3 WorldNormal263_g83300 = normalWS;
				half4 localSampleStochastic3D263_g83300 = SampleStochastic3D( Texture263_g83300 , Sampler263_g83300 , Coords263_g83300 , WorldPosition263_g83300 , WorldNormal263_g83300 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8640_g83242 = localSamplePlanar2D238_g83300;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8640_g83242 = localSamplePlanar3D246_g83300;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8640_g83242 = localSampleStochastic2D234_g83300;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8640_g83242 = localSampleStochastic3D263_g83300;
				#else
				float4 staticSwitch8640_g83242 = localSamplePlanar2D238_g83300;
				#endif
				float4 temp_output_7_0_g83250 = _MaskMin2;
				float4 temp_output_10_0_g83250 = ( _MaskMax2 - temp_output_7_0_g83250 );
				float4 temp_output_6977_0_g83242 = saturate( ( ( staticSwitch8640_g83242 - temp_output_7_0_g83250 ) / ( temp_output_10_0_g83250 + 0.0001 ) ) );
				half4 Masks_0210_g83256 = temp_output_6977_0_g83242;
				TEXTURE2D(Texture238_g83301) = _MaskTex3;
				SamplerState Sampler238_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_036789_g83242 = _Coords3;
				float4 temp_output_37_0_g83301 = Input_Coords_036789_g83242;
				half4 Coords238_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition238_g83301 = ase_worldPos;
				half4 localSamplePlanar2D238_g83301 = SamplePlanar2D( Texture238_g83301 , Sampler238_g83301 , Coords238_g83301 , WorldPosition238_g83301 );
				TEXTURE2D(Texture246_g83301) = _MaskTex3;
				SamplerState Sampler246_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition246_g83301 = ase_worldPos;
				half3 WorldNormal246_g83301 = normalWS;
				half4 localSamplePlanar3D246_g83301 = SamplePlanar3D( Texture246_g83301 , Sampler246_g83301 , Coords246_g83301 , WorldPosition246_g83301 , WorldNormal246_g83301 );
				TEXTURE2D(Texture234_g83301) = _MaskTex3;
				SamplerState Sampler234_g83301 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83301 = temp_output_37_0_g83301;
				float3 WorldPosition234_g83301 = ase_worldPos;
				float4 localSampleStochastic2D234_g83301 = SampleStochastic2D( Texture234_g83301 , Sampler234_g83301 , Coords234_g83301 , WorldPosition234_g83301 );
				TEXTURE2D(Texture263_g83301) = _MaskTex3;
				SamplerState Sampler263_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition263_g83301 = ase_worldPos;
				half3 WorldNormal263_g83301 = normalWS;
				half4 localSampleStochastic3D263_g83301 = SampleStochastic3D( Texture263_g83301 , Sampler263_g83301 , Coords263_g83301 , WorldPosition263_g83301 , WorldNormal263_g83301 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8641_g83242 = localSamplePlanar2D238_g83301;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8641_g83242 = localSamplePlanar3D246_g83301;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8641_g83242 = localSampleStochastic2D234_g83301;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8641_g83242 = localSampleStochastic3D263_g83301;
				#else
				float4 staticSwitch8641_g83242 = localSamplePlanar2D238_g83301;
				#endif
				float4 temp_output_7_0_g83251 = _MaskMin3;
				float4 temp_output_10_0_g83251 = ( _MaskMax3 - temp_output_7_0_g83251 );
				float4 temp_output_6978_0_g83242 = saturate( ( ( staticSwitch8641_g83242 - temp_output_7_0_g83251 ) / ( temp_output_10_0_g83251 + 0.0001 ) ) );
				half4 Masks_0312_g83256 = temp_output_6978_0_g83242;
				TEXTURE2D(Texture238_g83302) = _MaskTex4;
				SamplerState Sampler238_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_046791_g83242 = _Coords4;
				float4 temp_output_37_0_g83302 = Input_Coords_046791_g83242;
				half4 Coords238_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition238_g83302 = ase_worldPos;
				half4 localSamplePlanar2D238_g83302 = SamplePlanar2D( Texture238_g83302 , Sampler238_g83302 , Coords238_g83302 , WorldPosition238_g83302 );
				TEXTURE2D(Texture246_g83302) = _MaskTex4;
				SamplerState Sampler246_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition246_g83302 = ase_worldPos;
				half3 WorldNormal246_g83302 = normalWS;
				half4 localSamplePlanar3D246_g83302 = SamplePlanar3D( Texture246_g83302 , Sampler246_g83302 , Coords246_g83302 , WorldPosition246_g83302 , WorldNormal246_g83302 );
				TEXTURE2D(Texture234_g83302) = _MaskTex4;
				SamplerState Sampler234_g83302 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83302 = temp_output_37_0_g83302;
				float3 WorldPosition234_g83302 = ase_worldPos;
				float4 localSampleStochastic2D234_g83302 = SampleStochastic2D( Texture234_g83302 , Sampler234_g83302 , Coords234_g83302 , WorldPosition234_g83302 );
				TEXTURE2D(Texture263_g83302) = _MaskTex4;
				SamplerState Sampler263_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition263_g83302 = ase_worldPos;
				half3 WorldNormal263_g83302 = normalWS;
				half4 localSampleStochastic3D263_g83302 = SampleStochastic3D( Texture263_g83302 , Sampler263_g83302 , Coords263_g83302 , WorldPosition263_g83302 , WorldNormal263_g83302 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8642_g83242 = localSamplePlanar2D238_g83302;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8642_g83242 = localSamplePlanar3D246_g83302;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8642_g83242 = localSampleStochastic2D234_g83302;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8642_g83242 = localSampleStochastic3D263_g83302;
				#else
				float4 staticSwitch8642_g83242 = localSamplePlanar2D238_g83302;
				#endif
				float4 temp_output_7_0_g83252 = _MaskMin4;
				float4 temp_output_10_0_g83252 = ( _MaskMax4 - temp_output_7_0_g83252 );
				float4 temp_output_6983_0_g83242 = saturate( ( ( staticSwitch8642_g83242 - temp_output_7_0_g83252 ) / ( temp_output_10_0_g83252 + 0.0001 ) ) );
				half4 Masks_0414_g83256 = temp_output_6983_0_g83242;
				float4 appendResult29_g83256 = (float4((Masks_015_g83256).z , (Masks_0210_g83256).z , (Masks_0312_g83256).z , (Masks_0414_g83256).z));
				half4 Control31_g83256 = Terrain_Control_047365_g83242;
				half4 Terrain_Height_047210_g83242 = ( appendResult29_g83256 * Control31_g83256 );
				float4 heights_047362_g83242 = Terrain_Height_047210_g83242;
				TEXTURE2D(Texture238_g83311) = _MaskTex5;
				SamplerState Sampler238_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_058750_g83242 = _Coords5;
				float4 temp_output_37_0_g83311 = Input_Coords_058750_g83242;
				half4 Coords238_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition238_g83311 = ase_worldPos;
				half4 localSamplePlanar2D238_g83311 = SamplePlanar2D( Texture238_g83311 , Sampler238_g83311 , Coords238_g83311 , WorldPosition238_g83311 );
				TEXTURE2D(Texture246_g83311) = _MaskTex5;
				SamplerState Sampler246_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition246_g83311 = ase_worldPos;
				half3 WorldNormal246_g83311 = normalWS;
				half4 localSamplePlanar3D246_g83311 = SamplePlanar3D( Texture246_g83311 , Sampler246_g83311 , Coords246_g83311 , WorldPosition246_g83311 , WorldNormal246_g83311 );
				TEXTURE2D(Texture234_g83311) = _MaskTex5;
				SamplerState Sampler234_g83311 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83311 = temp_output_37_0_g83311;
				float3 WorldPosition234_g83311 = ase_worldPos;
				float4 localSampleStochastic2D234_g83311 = SampleStochastic2D( Texture234_g83311 , Sampler234_g83311 , Coords234_g83311 , WorldPosition234_g83311 );
				TEXTURE2D(Texture263_g83311) = _MaskTex5;
				SamplerState Sampler263_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition263_g83311 = ase_worldPos;
				half3 WorldNormal263_g83311 = normalWS;
				half4 localSampleStochastic3D263_g83311 = SampleStochastic3D( Texture263_g83311 , Sampler263_g83311 , Coords263_g83311 , WorldPosition263_g83311 , WorldNormal263_g83311 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8710_g83242 = localSamplePlanar2D238_g83311;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8710_g83242 = localSamplePlanar3D246_g83311;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8710_g83242 = localSampleStochastic2D234_g83311;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8710_g83242 = localSampleStochastic3D263_g83311;
				#else
				float4 staticSwitch8710_g83242 = localSamplePlanar2D238_g83311;
				#endif
				float4 temp_output_7_0_g83264 = _MaskMin5;
				float4 temp_output_10_0_g83264 = ( _MaskMax5 - temp_output_7_0_g83264 );
				float4 temp_output_8714_0_g83242 = saturate( ( ( staticSwitch8710_g83242 - temp_output_7_0_g83264 ) / ( temp_output_10_0_g83264 + 0.0001 ) ) );
				half4 Masks_015_g83265 = temp_output_8714_0_g83242;
				TEXTURE2D(Texture238_g83312) = _MaskTex6;
				SamplerState Sampler238_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_068751_g83242 = _Coords6;
				float4 temp_output_37_0_g83312 = Input_Coords_068751_g83242;
				half4 Coords238_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition238_g83312 = ase_worldPos;
				half4 localSamplePlanar2D238_g83312 = SamplePlanar2D( Texture238_g83312 , Sampler238_g83312 , Coords238_g83312 , WorldPosition238_g83312 );
				TEXTURE2D(Texture246_g83312) = _MaskTex6;
				SamplerState Sampler246_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition246_g83312 = ase_worldPos;
				half3 WorldNormal246_g83312 = normalWS;
				half4 localSamplePlanar3D246_g83312 = SamplePlanar3D( Texture246_g83312 , Sampler246_g83312 , Coords246_g83312 , WorldPosition246_g83312 , WorldNormal246_g83312 );
				TEXTURE2D(Texture234_g83312) = _MaskTex6;
				SamplerState Sampler234_g83312 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83312 = temp_output_37_0_g83312;
				float3 WorldPosition234_g83312 = ase_worldPos;
				float4 localSampleStochastic2D234_g83312 = SampleStochastic2D( Texture234_g83312 , Sampler234_g83312 , Coords234_g83312 , WorldPosition234_g83312 );
				TEXTURE2D(Texture263_g83312) = _MaskTex6;
				SamplerState Sampler263_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition263_g83312 = ase_worldPos;
				half3 WorldNormal263_g83312 = normalWS;
				half4 localSampleStochastic3D263_g83312 = SampleStochastic3D( Texture263_g83312 , Sampler263_g83312 , Coords263_g83312 , WorldPosition263_g83312 , WorldNormal263_g83312 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8711_g83242 = localSamplePlanar2D238_g83312;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8711_g83242 = localSamplePlanar3D246_g83312;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8711_g83242 = localSampleStochastic2D234_g83312;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8711_g83242 = localSampleStochastic3D263_g83312;
				#else
				float4 staticSwitch8711_g83242 = localSamplePlanar2D238_g83312;
				#endif
				float4 temp_output_7_0_g83267 = _MaskMin6;
				float4 temp_output_10_0_g83267 = ( _MaskMax6 - temp_output_7_0_g83267 );
				float4 temp_output_8721_0_g83242 = saturate( ( ( staticSwitch8711_g83242 - temp_output_7_0_g83267 ) / ( temp_output_10_0_g83267 + 0.0001 ) ) );
				half4 Masks_0210_g83265 = temp_output_8721_0_g83242;
				TEXTURE2D(Texture238_g83313) = _MaskTex7;
				SamplerState Sampler238_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_078752_g83242 = _Coords7;
				float4 temp_output_37_0_g83313 = Input_Coords_078752_g83242;
				half4 Coords238_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition238_g83313 = ase_worldPos;
				half4 localSamplePlanar2D238_g83313 = SamplePlanar2D( Texture238_g83313 , Sampler238_g83313 , Coords238_g83313 , WorldPosition238_g83313 );
				TEXTURE2D(Texture246_g83313) = _MaskTex7;
				SamplerState Sampler246_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition246_g83313 = ase_worldPos;
				half3 WorldNormal246_g83313 = normalWS;
				half4 localSamplePlanar3D246_g83313 = SamplePlanar3D( Texture246_g83313 , Sampler246_g83313 , Coords246_g83313 , WorldPosition246_g83313 , WorldNormal246_g83313 );
				TEXTURE2D(Texture234_g83313) = _MaskTex7;
				SamplerState Sampler234_g83313 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83313 = temp_output_37_0_g83313;
				float3 WorldPosition234_g83313 = ase_worldPos;
				float4 localSampleStochastic2D234_g83313 = SampleStochastic2D( Texture234_g83313 , Sampler234_g83313 , Coords234_g83313 , WorldPosition234_g83313 );
				TEXTURE2D(Texture263_g83313) = _MaskTex7;
				SamplerState Sampler263_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition263_g83313 = ase_worldPos;
				half3 WorldNormal263_g83313 = normalWS;
				half4 localSampleStochastic3D263_g83313 = SampleStochastic3D( Texture263_g83313 , Sampler263_g83313 , Coords263_g83313 , WorldPosition263_g83313 , WorldNormal263_g83313 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8712_g83242 = localSamplePlanar2D238_g83313;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8712_g83242 = localSamplePlanar3D246_g83313;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8712_g83242 = localSampleStochastic2D234_g83313;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8712_g83242 = localSampleStochastic3D263_g83313;
				#else
				float4 staticSwitch8712_g83242 = localSamplePlanar2D238_g83313;
				#endif
				float4 temp_output_7_0_g83268 = _MaskMin7;
				float4 temp_output_10_0_g83268 = ( _MaskMax7 - temp_output_7_0_g83268 );
				float4 temp_output_8724_0_g83242 = saturate( ( ( staticSwitch8712_g83242 - temp_output_7_0_g83268 ) / ( temp_output_10_0_g83268 + 0.0001 ) ) );
				half4 Masks_0312_g83265 = temp_output_8724_0_g83242;
				TEXTURE2D(Texture238_g83314) = _MaskTex8;
				SamplerState Sampler238_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_088749_g83242 = _Coords8;
				float4 temp_output_37_0_g83314 = Input_Coords_088749_g83242;
				half4 Coords238_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition238_g83314 = ase_worldPos;
				half4 localSamplePlanar2D238_g83314 = SamplePlanar2D( Texture238_g83314 , Sampler238_g83314 , Coords238_g83314 , WorldPosition238_g83314 );
				TEXTURE2D(Texture246_g83314) = _MaskTex8;
				SamplerState Sampler246_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition246_g83314 = ase_worldPos;
				half3 WorldNormal246_g83314 = normalWS;
				half4 localSamplePlanar3D246_g83314 = SamplePlanar3D( Texture246_g83314 , Sampler246_g83314 , Coords246_g83314 , WorldPosition246_g83314 , WorldNormal246_g83314 );
				TEXTURE2D(Texture234_g83314) = _MaskTex8;
				SamplerState Sampler234_g83314 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83314 = temp_output_37_0_g83314;
				float3 WorldPosition234_g83314 = ase_worldPos;
				float4 localSampleStochastic2D234_g83314 = SampleStochastic2D( Texture234_g83314 , Sampler234_g83314 , Coords234_g83314 , WorldPosition234_g83314 );
				TEXTURE2D(Texture263_g83314) = _MaskTex8;
				SamplerState Sampler263_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition263_g83314 = ase_worldPos;
				half3 WorldNormal263_g83314 = normalWS;
				half4 localSampleStochastic3D263_g83314 = SampleStochastic3D( Texture263_g83314 , Sampler263_g83314 , Coords263_g83314 , WorldPosition263_g83314 , WorldNormal263_g83314 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8713_g83242 = localSamplePlanar2D238_g83314;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8713_g83242 = localSamplePlanar3D246_g83314;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8713_g83242 = localSampleStochastic2D234_g83314;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8713_g83242 = localSampleStochastic3D263_g83314;
				#else
				float4 staticSwitch8713_g83242 = localSamplePlanar2D238_g83314;
				#endif
				float4 temp_output_7_0_g83269 = _MaskMin8;
				float4 temp_output_10_0_g83269 = ( _MaskMax8 - temp_output_7_0_g83269 );
				float4 temp_output_8727_0_g83242 = saturate( ( ( staticSwitch8713_g83242 - temp_output_7_0_g83269 ) / ( temp_output_10_0_g83269 + 0.0001 ) ) );
				half4 Masks_0414_g83265 = temp_output_8727_0_g83242;
				float4 appendResult29_g83265 = (float4((Masks_015_g83265).z , (Masks_0210_g83265).z , (Masks_0312_g83265).z , (Masks_0414_g83265).z));
				half4 Control31_g83265 = Terrain_Control_087366_g83242;
				half4 Terrain_Height_088731_g83242 = ( appendResult29_g83265 * Control31_g83265 );
				float4 heights_087362_g83242 = Terrain_Height_088731_g83242;
				TEXTURE2D(Texture238_g83323) = _MaskTex9;
				SamplerState Sampler238_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_098833_g83242 = _Coords9;
				float4 temp_output_37_0_g83323 = Input_Coords_098833_g83242;
				half4 Coords238_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition238_g83323 = ase_worldPos;
				half4 localSamplePlanar2D238_g83323 = SamplePlanar2D( Texture238_g83323 , Sampler238_g83323 , Coords238_g83323 , WorldPosition238_g83323 );
				TEXTURE2D(Texture246_g83323) = _MaskTex9;
				SamplerState Sampler246_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition246_g83323 = ase_worldPos;
				half3 WorldNormal246_g83323 = normalWS;
				half4 localSamplePlanar3D246_g83323 = SamplePlanar3D( Texture246_g83323 , Sampler246_g83323 , Coords246_g83323 , WorldPosition246_g83323 , WorldNormal246_g83323 );
				TEXTURE2D(Texture234_g83323) = _MaskTex9;
				SamplerState Sampler234_g83323 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83323 = temp_output_37_0_g83323;
				float3 WorldPosition234_g83323 = ase_worldPos;
				float4 localSampleStochastic2D234_g83323 = SampleStochastic2D( Texture234_g83323 , Sampler234_g83323 , Coords234_g83323 , WorldPosition234_g83323 );
				TEXTURE2D(Texture263_g83323) = _MaskTex9;
				SamplerState Sampler263_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition263_g83323 = ase_worldPos;
				half3 WorldNormal263_g83323 = normalWS;
				half4 localSampleStochastic3D263_g83323 = SampleStochastic3D( Texture263_g83323 , Sampler263_g83323 , Coords263_g83323 , WorldPosition263_g83323 , WorldNormal263_g83323 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8878_g83242 = localSamplePlanar2D238_g83323;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8878_g83242 = localSamplePlanar3D246_g83323;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8878_g83242 = localSampleStochastic2D234_g83323;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8878_g83242 = localSampleStochastic3D263_g83323;
				#else
				float4 staticSwitch8878_g83242 = localSamplePlanar2D238_g83323;
				#endif
				float4 temp_output_7_0_g83274 = _MaskMin9;
				float4 temp_output_10_0_g83274 = ( _MaskMax9 - temp_output_7_0_g83274 );
				float4 temp_output_8815_0_g83242 = saturate( ( ( staticSwitch8878_g83242 - temp_output_7_0_g83274 ) / ( temp_output_10_0_g83274 + 0.0001 ) ) );
				half4 Masks_015_g83275 = temp_output_8815_0_g83242;
				TEXTURE2D(Texture238_g83324) = _MaskTex10;
				SamplerState Sampler238_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_108834_g83242 = _Coords10;
				float4 temp_output_37_0_g83324 = Input_Coords_108834_g83242;
				half4 Coords238_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition238_g83324 = ase_worldPos;
				half4 localSamplePlanar2D238_g83324 = SamplePlanar2D( Texture238_g83324 , Sampler238_g83324 , Coords238_g83324 , WorldPosition238_g83324 );
				TEXTURE2D(Texture246_g83324) = _MaskTex10;
				SamplerState Sampler246_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition246_g83324 = ase_worldPos;
				half3 WorldNormal246_g83324 = normalWS;
				half4 localSamplePlanar3D246_g83324 = SamplePlanar3D( Texture246_g83324 , Sampler246_g83324 , Coords246_g83324 , WorldPosition246_g83324 , WorldNormal246_g83324 );
				TEXTURE2D(Texture234_g83324) = _MaskTex10;
				SamplerState Sampler234_g83324 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83324 = temp_output_37_0_g83324;
				float3 WorldPosition234_g83324 = ase_worldPos;
				float4 localSampleStochastic2D234_g83324 = SampleStochastic2D( Texture234_g83324 , Sampler234_g83324 , Coords234_g83324 , WorldPosition234_g83324 );
				TEXTURE2D(Texture263_g83324) = _MaskTex10;
				SamplerState Sampler263_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition263_g83324 = ase_worldPos;
				half3 WorldNormal263_g83324 = normalWS;
				half4 localSampleStochastic3D263_g83324 = SampleStochastic3D( Texture263_g83324 , Sampler263_g83324 , Coords263_g83324 , WorldPosition263_g83324 , WorldNormal263_g83324 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8860_g83242 = localSamplePlanar2D238_g83324;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8860_g83242 = localSamplePlanar3D246_g83324;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8860_g83242 = localSampleStochastic2D234_g83324;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8860_g83242 = localSampleStochastic3D263_g83324;
				#else
				float4 staticSwitch8860_g83242 = localSamplePlanar2D238_g83324;
				#endif
				float4 temp_output_7_0_g83277 = _MaskMin10;
				float4 temp_output_10_0_g83277 = ( _MaskMax10 - temp_output_7_0_g83277 );
				float4 temp_output_8818_0_g83242 = saturate( ( ( staticSwitch8860_g83242 - temp_output_7_0_g83277 ) / ( temp_output_10_0_g83277 + 0.0001 ) ) );
				half4 Masks_0210_g83275 = temp_output_8818_0_g83242;
				TEXTURE2D(Texture238_g83325) = _MaskTex11;
				SamplerState Sampler238_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_118835_g83242 = _Coords11;
				float4 temp_output_37_0_g83325 = Input_Coords_118835_g83242;
				half4 Coords238_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition238_g83325 = ase_worldPos;
				half4 localSamplePlanar2D238_g83325 = SamplePlanar2D( Texture238_g83325 , Sampler238_g83325 , Coords238_g83325 , WorldPosition238_g83325 );
				TEXTURE2D(Texture246_g83325) = _MaskTex11;
				SamplerState Sampler246_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition246_g83325 = ase_worldPos;
				half3 WorldNormal246_g83325 = normalWS;
				half4 localSamplePlanar3D246_g83325 = SamplePlanar3D( Texture246_g83325 , Sampler246_g83325 , Coords246_g83325 , WorldPosition246_g83325 , WorldNormal246_g83325 );
				TEXTURE2D(Texture234_g83325) = _MaskTex11;
				SamplerState Sampler234_g83325 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83325 = temp_output_37_0_g83325;
				float3 WorldPosition234_g83325 = ase_worldPos;
				float4 localSampleStochastic2D234_g83325 = SampleStochastic2D( Texture234_g83325 , Sampler234_g83325 , Coords234_g83325 , WorldPosition234_g83325 );
				TEXTURE2D(Texture263_g83325) = _MaskTex11;
				SamplerState Sampler263_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition263_g83325 = ase_worldPos;
				half3 WorldNormal263_g83325 = normalWS;
				half4 localSampleStochastic3D263_g83325 = SampleStochastic3D( Texture263_g83325 , Sampler263_g83325 , Coords263_g83325 , WorldPosition263_g83325 , WorldNormal263_g83325 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8861_g83242 = localSamplePlanar2D238_g83325;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8861_g83242 = localSamplePlanar3D246_g83325;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8861_g83242 = localSampleStochastic2D234_g83325;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8861_g83242 = localSampleStochastic3D263_g83325;
				#else
				float4 staticSwitch8861_g83242 = localSamplePlanar2D238_g83325;
				#endif
				float4 temp_output_7_0_g83278 = _MaskMin11;
				float4 temp_output_10_0_g83278 = ( _MaskMax11 - temp_output_7_0_g83278 );
				float4 temp_output_8819_0_g83242 = saturate( ( ( staticSwitch8861_g83242 - temp_output_7_0_g83278 ) / ( temp_output_10_0_g83278 + 0.0001 ) ) );
				half4 Masks_0312_g83275 = temp_output_8819_0_g83242;
				TEXTURE2D(Texture238_g83326) = _MaskTex12;
				SamplerState Sampler238_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_128836_g83242 = _Coords12;
				float4 temp_output_37_0_g83326 = Input_Coords_128836_g83242;
				half4 Coords238_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition238_g83326 = ase_worldPos;
				half4 localSamplePlanar2D238_g83326 = SamplePlanar2D( Texture238_g83326 , Sampler238_g83326 , Coords238_g83326 , WorldPosition238_g83326 );
				TEXTURE2D(Texture246_g83326) = _MaskTex12;
				SamplerState Sampler246_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition246_g83326 = ase_worldPos;
				half3 WorldNormal246_g83326 = normalWS;
				half4 localSamplePlanar3D246_g83326 = SamplePlanar3D( Texture246_g83326 , Sampler246_g83326 , Coords246_g83326 , WorldPosition246_g83326 , WorldNormal246_g83326 );
				TEXTURE2D(Texture234_g83326) = _MaskTex12;
				SamplerState Sampler234_g83326 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83326 = temp_output_37_0_g83326;
				float3 WorldPosition234_g83326 = ase_worldPos;
				float4 localSampleStochastic2D234_g83326 = SampleStochastic2D( Texture234_g83326 , Sampler234_g83326 , Coords234_g83326 , WorldPosition234_g83326 );
				TEXTURE2D(Texture263_g83326) = _MaskTex12;
				SamplerState Sampler263_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition263_g83326 = ase_worldPos;
				half3 WorldNormal263_g83326 = normalWS;
				half4 localSampleStochastic3D263_g83326 = SampleStochastic3D( Texture263_g83326 , Sampler263_g83326 , Coords263_g83326 , WorldPosition263_g83326 , WorldNormal263_g83326 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8879_g83242 = localSamplePlanar2D238_g83326;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8879_g83242 = localSamplePlanar3D246_g83326;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8879_g83242 = localSampleStochastic2D234_g83326;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8879_g83242 = localSampleStochastic3D263_g83326;
				#else
				float4 staticSwitch8879_g83242 = localSamplePlanar2D238_g83326;
				#endif
				float4 temp_output_7_0_g83279 = _MaskMin12;
				float4 temp_output_10_0_g83279 = ( _MaskMax12 - temp_output_7_0_g83279 );
				float4 temp_output_8820_0_g83242 = saturate( ( ( staticSwitch8879_g83242 - temp_output_7_0_g83279 ) / ( temp_output_10_0_g83279 + 0.0001 ) ) );
				half4 Masks_0414_g83275 = temp_output_8820_0_g83242;
				float4 appendResult29_g83275 = (float4((Masks_015_g83275).z , (Masks_0210_g83275).z , (Masks_0312_g83275).z , (Masks_0414_g83275).z));
				half4 Control31_g83275 = Terrain_Control_127712_g83242;
				half4 Terrain_Height_128870_g83242 = ( appendResult29_g83275 * Control31_g83275 );
				float4 heights_127362_g83242 = Terrain_Height_128870_g83242;
				TEXTURE2D(Texture238_g83334) = _MaskTex13;
				SamplerState Sampler238_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_138960_g83242 = _Coords13;
				float4 temp_output_37_0_g83334 = Input_Coords_138960_g83242;
				half4 Coords238_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition238_g83334 = ase_worldPos;
				half4 localSamplePlanar2D238_g83334 = SamplePlanar2D( Texture238_g83334 , Sampler238_g83334 , Coords238_g83334 , WorldPosition238_g83334 );
				TEXTURE2D(Texture246_g83334) = _MaskTex13;
				SamplerState Sampler246_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition246_g83334 = ase_worldPos;
				half3 WorldNormal246_g83334 = normalWS;
				half4 localSamplePlanar3D246_g83334 = SamplePlanar3D( Texture246_g83334 , Sampler246_g83334 , Coords246_g83334 , WorldPosition246_g83334 , WorldNormal246_g83334 );
				TEXTURE2D(Texture234_g83334) = _MaskTex13;
				SamplerState Sampler234_g83334 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83334 = temp_output_37_0_g83334;
				float3 WorldPosition234_g83334 = ase_worldPos;
				float4 localSampleStochastic2D234_g83334 = SampleStochastic2D( Texture234_g83334 , Sampler234_g83334 , Coords234_g83334 , WorldPosition234_g83334 );
				TEXTURE2D(Texture263_g83334) = _MaskTex13;
				SamplerState Sampler263_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition263_g83334 = ase_worldPos;
				half3 WorldNormal263_g83334 = normalWS;
				half4 localSampleStochastic3D263_g83334 = SampleStochastic3D( Texture263_g83334 , Sampler263_g83334 , Coords263_g83334 , WorldPosition263_g83334 , WorldNormal263_g83334 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch9000_g83242 = localSamplePlanar2D238_g83334;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch9000_g83242 = localSamplePlanar3D246_g83334;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch9000_g83242 = localSampleStochastic2D234_g83334;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch9000_g83242 = localSampleStochastic3D263_g83334;
				#else
				float4 staticSwitch9000_g83242 = localSamplePlanar2D238_g83334;
				#endif
				float4 temp_output_7_0_g83284 = _MaskMin13;
				float4 temp_output_10_0_g83284 = ( _MaskMax13 - temp_output_7_0_g83284 );
				float4 temp_output_8931_0_g83242 = saturate( ( ( staticSwitch9000_g83242 - temp_output_7_0_g83284 ) / ( temp_output_10_0_g83284 + 0.0001 ) ) );
				half4 Masks_015_g83285 = temp_output_8931_0_g83242;
				TEXTURE2D(Texture238_g83335) = _MaskTex14;
				SamplerState Sampler238_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_148961_g83242 = _Coords14;
				float4 temp_output_37_0_g83335 = Input_Coords_148961_g83242;
				half4 Coords238_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition238_g83335 = ase_worldPos;
				half4 localSamplePlanar2D238_g83335 = SamplePlanar2D( Texture238_g83335 , Sampler238_g83335 , Coords238_g83335 , WorldPosition238_g83335 );
				TEXTURE2D(Texture246_g83335) = _MaskTex14;
				SamplerState Sampler246_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition246_g83335 = ase_worldPos;
				half3 WorldNormal246_g83335 = normalWS;
				half4 localSamplePlanar3D246_g83335 = SamplePlanar3D( Texture246_g83335 , Sampler246_g83335 , Coords246_g83335 , WorldPosition246_g83335 , WorldNormal246_g83335 );
				TEXTURE2D(Texture234_g83335) = _MaskTex14;
				SamplerState Sampler234_g83335 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83335 = temp_output_37_0_g83335;
				float3 WorldPosition234_g83335 = ase_worldPos;
				float4 localSampleStochastic2D234_g83335 = SampleStochastic2D( Texture234_g83335 , Sampler234_g83335 , Coords234_g83335 , WorldPosition234_g83335 );
				TEXTURE2D(Texture263_g83335) = _MaskTex14;
				SamplerState Sampler263_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition263_g83335 = ase_worldPos;
				half3 WorldNormal263_g83335 = normalWS;
				half4 localSampleStochastic3D263_g83335 = SampleStochastic3D( Texture263_g83335 , Sampler263_g83335 , Coords263_g83335 , WorldPosition263_g83335 , WorldNormal263_g83335 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch9001_g83242 = localSamplePlanar2D238_g83335;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch9001_g83242 = localSamplePlanar3D246_g83335;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch9001_g83242 = localSampleStochastic2D234_g83335;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch9001_g83242 = localSampleStochastic3D263_g83335;
				#else
				float4 staticSwitch9001_g83242 = localSamplePlanar2D238_g83335;
				#endif
				float4 temp_output_7_0_g83287 = _MaskMin14;
				float4 temp_output_10_0_g83287 = ( _MaskMax14 - temp_output_7_0_g83287 );
				float4 temp_output_8934_0_g83242 = saturate( ( ( staticSwitch9001_g83242 - temp_output_7_0_g83287 ) / ( temp_output_10_0_g83287 + 0.0001 ) ) );
				half4 Masks_0210_g83285 = temp_output_8934_0_g83242;
				TEXTURE2D(Texture238_g83336) = _MaskTex15;
				SamplerState Sampler238_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_158962_g83242 = _Coords15;
				float4 temp_output_37_0_g83336 = Input_Coords_158962_g83242;
				half4 Coords238_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition238_g83336 = ase_worldPos;
				half4 localSamplePlanar2D238_g83336 = SamplePlanar2D( Texture238_g83336 , Sampler238_g83336 , Coords238_g83336 , WorldPosition238_g83336 );
				TEXTURE2D(Texture246_g83336) = _MaskTex15;
				SamplerState Sampler246_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition246_g83336 = ase_worldPos;
				half3 WorldNormal246_g83336 = normalWS;
				half4 localSamplePlanar3D246_g83336 = SamplePlanar3D( Texture246_g83336 , Sampler246_g83336 , Coords246_g83336 , WorldPosition246_g83336 , WorldNormal246_g83336 );
				TEXTURE2D(Texture234_g83336) = _MaskTex15;
				SamplerState Sampler234_g83336 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83336 = temp_output_37_0_g83336;
				float3 WorldPosition234_g83336 = ase_worldPos;
				float4 localSampleStochastic2D234_g83336 = SampleStochastic2D( Texture234_g83336 , Sampler234_g83336 , Coords234_g83336 , WorldPosition234_g83336 );
				TEXTURE2D(Texture263_g83336) = _MaskTex15;
				SamplerState Sampler263_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition263_g83336 = ase_worldPos;
				half3 WorldNormal263_g83336 = normalWS;
				half4 localSampleStochastic3D263_g83336 = SampleStochastic3D( Texture263_g83336 , Sampler263_g83336 , Coords263_g83336 , WorldPosition263_g83336 , WorldNormal263_g83336 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch9002_g83242 = localSamplePlanar2D238_g83336;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch9002_g83242 = localSamplePlanar3D246_g83336;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch9002_g83242 = localSampleStochastic2D234_g83336;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch9002_g83242 = localSampleStochastic3D263_g83336;
				#else
				float4 staticSwitch9002_g83242 = localSamplePlanar2D238_g83336;
				#endif
				float4 temp_output_7_0_g83288 = _MaskMin15;
				float4 temp_output_10_0_g83288 = ( _MaskMax15 - temp_output_7_0_g83288 );
				float4 temp_output_8935_0_g83242 = saturate( ( ( staticSwitch9002_g83242 - temp_output_7_0_g83288 ) / ( temp_output_10_0_g83288 + 0.0001 ) ) );
				half4 Masks_0312_g83285 = temp_output_8935_0_g83242;
				TEXTURE2D(Texture238_g83337) = _MaskTex16;
				SamplerState Sampler238_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_168959_g83242 = _Coords16;
				float4 temp_output_37_0_g83337 = Input_Coords_168959_g83242;
				half4 Coords238_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition238_g83337 = ase_worldPos;
				half4 localSamplePlanar2D238_g83337 = SamplePlanar2D( Texture238_g83337 , Sampler238_g83337 , Coords238_g83337 , WorldPosition238_g83337 );
				TEXTURE2D(Texture246_g83337) = _MaskTex16;
				SamplerState Sampler246_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition246_g83337 = ase_worldPos;
				half3 WorldNormal246_g83337 = normalWS;
				half4 localSamplePlanar3D246_g83337 = SamplePlanar3D( Texture246_g83337 , Sampler246_g83337 , Coords246_g83337 , WorldPosition246_g83337 , WorldNormal246_g83337 );
				TEXTURE2D(Texture234_g83337) = _MaskTex16;
				SamplerState Sampler234_g83337 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83337 = temp_output_37_0_g83337;
				float3 WorldPosition234_g83337 = ase_worldPos;
				float4 localSampleStochastic2D234_g83337 = SampleStochastic2D( Texture234_g83337 , Sampler234_g83337 , Coords234_g83337 , WorldPosition234_g83337 );
				TEXTURE2D(Texture263_g83337) = _MaskTex16;
				SamplerState Sampler263_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition263_g83337 = ase_worldPos;
				half3 WorldNormal263_g83337 = normalWS;
				half4 localSampleStochastic3D263_g83337 = SampleStochastic3D( Texture263_g83337 , Sampler263_g83337 , Coords263_g83337 , WorldPosition263_g83337 , WorldNormal263_g83337 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch9003_g83242 = localSamplePlanar2D238_g83337;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch9003_g83242 = localSamplePlanar3D246_g83337;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch9003_g83242 = localSampleStochastic2D234_g83337;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch9003_g83242 = localSampleStochastic3D263_g83337;
				#else
				float4 staticSwitch9003_g83242 = localSamplePlanar2D238_g83337;
				#endif
				float4 temp_output_7_0_g83289 = _MaskMin16;
				float4 temp_output_10_0_g83289 = ( _MaskMax16 - temp_output_7_0_g83289 );
				float4 temp_output_8936_0_g83242 = saturate( ( ( staticSwitch9003_g83242 - temp_output_7_0_g83289 ) / ( temp_output_10_0_g83289 + 0.0001 ) ) );
				half4 Masks_0414_g83285 = temp_output_8936_0_g83242;
				float4 appendResult29_g83285 = (float4((Masks_015_g83285).z , (Masks_0210_g83285).z , (Masks_0312_g83285).z , (Masks_0414_g83285).z));
				half4 Control31_g83285 = Terrain_Control_167711_g83242;
				half4 Terrain_Height_169015_g83242 = ( appendResult29_g83285 * Control31_g83285 );
				float4 heights_167362_g83242 = Terrain_Height_169015_g83242;
				float heightTransition7362_g83242 = ( 1.0 - _TerrainHeightBlendValue );
				float4 weights_047362_g83242 = float4( 0,0,0,0 );
				float4 weights_087362_g83242 = float4( 0,0,0,0 );
				float4 weights_127362_g83242 = float4( 0,0,0,0 );
				float4 weights_167362_g83242 = float4( 0,0,0,0 );
				{
				//Modified version of the HDRP terrain height based blending
				float maxHeight = 0;
				float4 weightedHeights_04 = float4( 0,0,0,0 );
				float4 weightedHeights_08 = float4( 0,0,0,0 );
				float4 weightedHeights_12 = float4( 0,0,0,0 );
				float4 weightedHeights_16 = float4( 0,0,0,0 );
				maxHeight = heights_047362_g83242.x;
				maxHeight = max(maxHeight, heights_047362_g83242.y);
				maxHeight = max(maxHeight, heights_047362_g83242.z);
				maxHeight = max(maxHeight, heights_047362_g83242.w);
				#ifdef TVE_TERRAIN_08
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				#endif
				#ifdef TVE_TERRAIN_12
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				maxHeight = max(maxHeight, heights_127362_g83242.x);
				maxHeight = max(maxHeight, heights_127362_g83242.y);
				maxHeight = max(maxHeight, heights_127362_g83242.z);
				maxHeight = max(maxHeight, heights_127362_g83242.w);
				#endif
				#ifdef TVE_TERRAIN_16
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				maxHeight = max(maxHeight, heights_127362_g83242.x);
				maxHeight = max(maxHeight, heights_127362_g83242.y);
				maxHeight = max(maxHeight, heights_127362_g83242.z);
				maxHeight = max(maxHeight, heights_127362_g83242.w);
				maxHeight = max(maxHeight, heights_167362_g83242.x);
				maxHeight = max(maxHeight, heights_167362_g83242.y);
				maxHeight = max(maxHeight, heights_167362_g83242.z);
				maxHeight = max(maxHeight, heights_167362_g83242.w);
				#endif
				float transition = max(heightTransition7362_g83242, 0.01);
				weightedHeights_04 = float4 ( heights_047362_g83242.x, heights_047362_g83242.y, heights_047362_g83242.z, heights_047362_g83242.w );
				weightedHeights_04 = weightedHeights_04 - maxHeight.xxxx;
				weightedHeights_04 = (max(0, weightedHeights_04 + transition) + 1e-6) * control_047362_g83242;
				#ifdef TVE_TERRAIN_08
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				#endif
				#ifdef TVE_TERRAIN_12
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				weightedHeights_12 = float4 ( heights_127362_g83242.x, heights_127362_g83242.y, heights_127362_g83242.z, heights_127362_g83242.w );
				weightedHeights_12 = weightedHeights_12 - maxHeight.xxxx;
				weightedHeights_12 = (max(0, weightedHeights_12 + transition) + 1e-6) * control_127362_g83242;
				#endif
				#ifdef TVE_TERRAIN_16
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				weightedHeights_12 = float4 ( heights_127362_g83242.x, heights_127362_g83242.y, heights_127362_g83242.z, heights_127362_g83242.w );
				weightedHeights_12 = weightedHeights_12 - maxHeight.xxxx;
				weightedHeights_12 = (max(0, weightedHeights_12 + transition) + 1e-6) * control_127362_g83242;
				weightedHeights_16 = float4 ( heights_167362_g83242.x, heights_167362_g83242.y, heights_167362_g83242.z, heights_167362_g83242.w );
				weightedHeights_16 = weightedHeights_16 - maxHeight.xxxx;
				weightedHeights_16 = (max(0, weightedHeights_16 + transition) + 1e-6) * control_167362_g83242;
				#endif
				float sumHeight_04 = weightedHeights_04.x + weightedHeights_04.y + weightedHeights_04.z + weightedHeights_04.w;
				float sumHeight_08 = weightedHeights_08.x + weightedHeights_08.y + weightedHeights_08.z + weightedHeights_08.w;
				float sumHeight_12 = weightedHeights_12.x + weightedHeights_12.y + weightedHeights_12.z + weightedHeights_12.w;
				float sumHeight_16 = weightedHeights_16.x + weightedHeights_16.y + weightedHeights_16.z + weightedHeights_16.w;
				float sumHeight = sumHeight_04 + sumHeight_08 + sumHeight_12 + sumHeight_16;
				weights_047362_g83242 = weightedHeights_04 / sumHeight.xxxx;
				#ifdef TVE_TERRAIN_08
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				#endif
				#ifdef TVE_TERRAIN_12
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				weights_127362_g83242 = weightedHeights_12 / sumHeight.xxxx;
				#endif
				#ifdef TVE_TERRAIN_16
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				weights_127362_g83242 = weightedHeights_12 / sumHeight.xxxx;
				weights_167362_g83242 = weightedHeights_16 / sumHeight.xxxx;
				#endif
				}
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8792_g83242 = weights_047362_g83242;
				#else
				float4 staticSwitch8792_g83242 = control_047362_g83242;
				#endif
				half4 Terrain_Weights_046781_g83242 = staticSwitch8792_g83242;
				half4 Weights52_g83247 = Terrain_Weights_046781_g83242;
				TEXTURE2D(Texture238_g83295) = _NormalTex1;
				SamplerState Sampler238_g83295 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83295 = Input_Coords_016785_g83242;
				half4 Coords238_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition238_g83295 = ase_worldPos;
				half4 localSamplePlanar2D238_g83295 = SamplePlanar2D( Texture238_g83295 , Sampler238_g83295 , Coords238_g83295 , WorldPosition238_g83295 );
				TEXTURE2D(Texture246_g83295) = _NormalTex1;
				SamplerState Sampler246_g83295 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition246_g83295 = ase_worldPos;
				half3 WorldNormal246_g83295 = normalWS;
				half4 localSamplePlanar3D246_g83295 = SamplePlanar3D( Texture246_g83295 , Sampler246_g83295 , Coords246_g83295 , WorldPosition246_g83295 , WorldNormal246_g83295 );
				TEXTURE2D(Texture234_g83295) = _NormalTex1;
				SamplerState Sampler234_g83295 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83295 = temp_output_37_0_g83295;
				float3 WorldPosition234_g83295 = ase_worldPos;
				float4 localSampleStochastic2D234_g83295 = SampleStochastic2D( Texture234_g83295 , Sampler234_g83295 , Coords234_g83295 , WorldPosition234_g83295 );
				TEXTURE2D(Texture263_g83295) = _NormalTex1;
				SamplerState Sampler263_g83295 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition263_g83295 = ase_worldPos;
				half3 WorldNormal263_g83295 = normalWS;
				half4 localSampleStochastic3D263_g83295 = SampleStochastic3D( Texture263_g83295 , Sampler263_g83295 , Coords263_g83295 , WorldPosition263_g83295 , WorldNormal263_g83295 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8635_g83242 = localSamplePlanar2D238_g83295;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8635_g83242 = localSamplePlanar3D246_g83295;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8635_g83242 = localSampleStochastic2D234_g83295;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8635_g83242 = localSampleStochastic3D263_g83295;
				#else
				float4 staticSwitch8635_g83242 = localSamplePlanar2D238_g83295;
				#endif
				half4 Layer133_g83247 = staticSwitch8635_g83242;
				TEXTURE2D(Texture238_g83296) = _NormalTex2;
				SamplerState Sampler238_g83296 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83296 = Input_Coords_026787_g83242;
				half4 Coords238_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition238_g83296 = ase_worldPos;
				half4 localSamplePlanar2D238_g83296 = SamplePlanar2D( Texture238_g83296 , Sampler238_g83296 , Coords238_g83296 , WorldPosition238_g83296 );
				TEXTURE2D(Texture246_g83296) = _NormalTex2;
				SamplerState Sampler246_g83296 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition246_g83296 = ase_worldPos;
				half3 WorldNormal246_g83296 = normalWS;
				half4 localSamplePlanar3D246_g83296 = SamplePlanar3D( Texture246_g83296 , Sampler246_g83296 , Coords246_g83296 , WorldPosition246_g83296 , WorldNormal246_g83296 );
				TEXTURE2D(Texture234_g83296) = _NormalTex2;
				SamplerState Sampler234_g83296 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83296 = temp_output_37_0_g83296;
				float3 WorldPosition234_g83296 = ase_worldPos;
				float4 localSampleStochastic2D234_g83296 = SampleStochastic2D( Texture234_g83296 , Sampler234_g83296 , Coords234_g83296 , WorldPosition234_g83296 );
				TEXTURE2D(Texture263_g83296) = _NormalTex2;
				SamplerState Sampler263_g83296 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition263_g83296 = ase_worldPos;
				half3 WorldNormal263_g83296 = normalWS;
				half4 localSampleStochastic3D263_g83296 = SampleStochastic3D( Texture263_g83296 , Sampler263_g83296 , Coords263_g83296 , WorldPosition263_g83296 , WorldNormal263_g83296 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8636_g83242 = localSamplePlanar2D238_g83296;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8636_g83242 = localSamplePlanar3D246_g83296;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8636_g83242 = localSampleStochastic2D234_g83296;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8636_g83242 = localSampleStochastic3D263_g83296;
				#else
				float4 staticSwitch8636_g83242 = localSamplePlanar2D238_g83296;
				#endif
				half4 Layer237_g83247 = staticSwitch8636_g83242;
				TEXTURE2D(Texture238_g83297) = _NormalTex3;
				SamplerState Sampler238_g83297 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83297 = Input_Coords_036789_g83242;
				half4 Coords238_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition238_g83297 = ase_worldPos;
				half4 localSamplePlanar2D238_g83297 = SamplePlanar2D( Texture238_g83297 , Sampler238_g83297 , Coords238_g83297 , WorldPosition238_g83297 );
				TEXTURE2D(Texture246_g83297) = _NormalTex3;
				SamplerState Sampler246_g83297 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition246_g83297 = ase_worldPos;
				half3 WorldNormal246_g83297 = normalWS;
				half4 localSamplePlanar3D246_g83297 = SamplePlanar3D( Texture246_g83297 , Sampler246_g83297 , Coords246_g83297 , WorldPosition246_g83297 , WorldNormal246_g83297 );
				TEXTURE2D(Texture234_g83297) = _NormalTex3;
				SamplerState Sampler234_g83297 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83297 = temp_output_37_0_g83297;
				float3 WorldPosition234_g83297 = ase_worldPos;
				float4 localSampleStochastic2D234_g83297 = SampleStochastic2D( Texture234_g83297 , Sampler234_g83297 , Coords234_g83297 , WorldPosition234_g83297 );
				TEXTURE2D(Texture263_g83297) = _NormalTex3;
				SamplerState Sampler263_g83297 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition263_g83297 = ase_worldPos;
				half3 WorldNormal263_g83297 = normalWS;
				half4 localSampleStochastic3D263_g83297 = SampleStochastic3D( Texture263_g83297 , Sampler263_g83297 , Coords263_g83297 , WorldPosition263_g83297 , WorldNormal263_g83297 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8637_g83242 = localSamplePlanar2D238_g83297;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8637_g83242 = localSamplePlanar3D246_g83297;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8637_g83242 = localSampleStochastic2D234_g83297;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8637_g83242 = localSampleStochastic3D263_g83297;
				#else
				float4 staticSwitch8637_g83242 = localSamplePlanar2D238_g83297;
				#endif
				half4 Layer338_g83247 = staticSwitch8637_g83242;
				TEXTURE2D(Texture238_g83298) = _NormalTex4;
				SamplerState Sampler238_g83298 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83298 = Input_Coords_046791_g83242;
				half4 Coords238_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition238_g83298 = ase_worldPos;
				half4 localSamplePlanar2D238_g83298 = SamplePlanar2D( Texture238_g83298 , Sampler238_g83298 , Coords238_g83298 , WorldPosition238_g83298 );
				TEXTURE2D(Texture246_g83298) = _NormalTex4;
				SamplerState Sampler246_g83298 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition246_g83298 = ase_worldPos;
				half3 WorldNormal246_g83298 = normalWS;
				half4 localSamplePlanar3D246_g83298 = SamplePlanar3D( Texture246_g83298 , Sampler246_g83298 , Coords246_g83298 , WorldPosition246_g83298 , WorldNormal246_g83298 );
				TEXTURE2D(Texture234_g83298) = _NormalTex4;
				SamplerState Sampler234_g83298 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83298 = temp_output_37_0_g83298;
				float3 WorldPosition234_g83298 = ase_worldPos;
				float4 localSampleStochastic2D234_g83298 = SampleStochastic2D( Texture234_g83298 , Sampler234_g83298 , Coords234_g83298 , WorldPosition234_g83298 );
				TEXTURE2D(Texture263_g83298) = _NormalTex4;
				SamplerState Sampler263_g83298 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition263_g83298 = ase_worldPos;
				half3 WorldNormal263_g83298 = normalWS;
				half4 localSampleStochastic3D263_g83298 = SampleStochastic3D( Texture263_g83298 , Sampler263_g83298 , Coords263_g83298 , WorldPosition263_g83298 , WorldNormal263_g83298 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8638_g83242 = localSamplePlanar2D238_g83298;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8638_g83242 = localSamplePlanar3D246_g83298;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8638_g83242 = localSampleStochastic2D234_g83298;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8638_g83242 = localSampleStochastic3D263_g83298;
				#else
				float4 staticSwitch8638_g83242 = localSamplePlanar2D238_g83298;
				#endif
				half4 Layer439_g83247 = staticSwitch8638_g83242;
				float4 weightedBlendVar31_g83247 = Weights52_g83247;
				float4 weightedBlend31_g83247 = ( weightedBlendVar31_g83247.x*Layer133_g83247 + weightedBlendVar31_g83247.y*Layer237_g83247 + weightedBlendVar31_g83247.z*Layer338_g83247 + weightedBlendVar31_g83247.w*Layer439_g83247 );
				half4 Terrain_Normal_047202_g83242 = weightedBlend31_g83247;
				half4 Layer_045_g83257 = Terrain_Normal_047202_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8793_g83242 = weights_087362_g83242;
				#else
				float4 staticSwitch8793_g83242 = control_087362_g83242;
				#endif
				half4 Terrain_Weights_087340_g83242 = staticSwitch8793_g83242;
				half4 Weights52_g83263 = Terrain_Weights_087340_g83242;
				TEXTURE2D(Texture238_g83307) = _NormalTex5;
				SamplerState Sampler238_g83307 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83307 = Input_Coords_058750_g83242;
				half4 Coords238_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition238_g83307 = ase_worldPos;
				half4 localSamplePlanar2D238_g83307 = SamplePlanar2D( Texture238_g83307 , Sampler238_g83307 , Coords238_g83307 , WorldPosition238_g83307 );
				TEXTURE2D(Texture246_g83307) = _NormalTex5;
				SamplerState Sampler246_g83307 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition246_g83307 = ase_worldPos;
				half3 WorldNormal246_g83307 = normalWS;
				half4 localSamplePlanar3D246_g83307 = SamplePlanar3D( Texture246_g83307 , Sampler246_g83307 , Coords246_g83307 , WorldPosition246_g83307 , WorldNormal246_g83307 );
				TEXTURE2D(Texture234_g83307) = _NormalTex5;
				SamplerState Sampler234_g83307 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83307 = temp_output_37_0_g83307;
				float3 WorldPosition234_g83307 = ase_worldPos;
				float4 localSampleStochastic2D234_g83307 = SampleStochastic2D( Texture234_g83307 , Sampler234_g83307 , Coords234_g83307 , WorldPosition234_g83307 );
				TEXTURE2D(Texture263_g83307) = _NormalTex5;
				SamplerState Sampler263_g83307 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition263_g83307 = ase_worldPos;
				half3 WorldNormal263_g83307 = normalWS;
				half4 localSampleStochastic3D263_g83307 = SampleStochastic3D( Texture263_g83307 , Sampler263_g83307 , Coords263_g83307 , WorldPosition263_g83307 , WorldNormal263_g83307 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8686_g83242 = localSamplePlanar2D238_g83307;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8686_g83242 = localSamplePlanar3D246_g83307;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8686_g83242 = localSampleStochastic2D234_g83307;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8686_g83242 = localSampleStochastic3D263_g83307;
				#else
				float4 staticSwitch8686_g83242 = localSamplePlanar2D238_g83307;
				#endif
				half4 Layer133_g83263 = staticSwitch8686_g83242;
				TEXTURE2D(Texture238_g83308) = _NormalTex6;
				SamplerState Sampler238_g83308 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83308 = Input_Coords_068751_g83242;
				half4 Coords238_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition238_g83308 = ase_worldPos;
				half4 localSamplePlanar2D238_g83308 = SamplePlanar2D( Texture238_g83308 , Sampler238_g83308 , Coords238_g83308 , WorldPosition238_g83308 );
				TEXTURE2D(Texture246_g83308) = _NormalTex6;
				SamplerState Sampler246_g83308 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition246_g83308 = ase_worldPos;
				half3 WorldNormal246_g83308 = normalWS;
				half4 localSamplePlanar3D246_g83308 = SamplePlanar3D( Texture246_g83308 , Sampler246_g83308 , Coords246_g83308 , WorldPosition246_g83308 , WorldNormal246_g83308 );
				TEXTURE2D(Texture234_g83308) = _NormalTex6;
				SamplerState Sampler234_g83308 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83308 = temp_output_37_0_g83308;
				float3 WorldPosition234_g83308 = ase_worldPos;
				float4 localSampleStochastic2D234_g83308 = SampleStochastic2D( Texture234_g83308 , Sampler234_g83308 , Coords234_g83308 , WorldPosition234_g83308 );
				TEXTURE2D(Texture263_g83308) = _NormalTex6;
				SamplerState Sampler263_g83308 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition263_g83308 = ase_worldPos;
				half3 WorldNormal263_g83308 = normalWS;
				half4 localSampleStochastic3D263_g83308 = SampleStochastic3D( Texture263_g83308 , Sampler263_g83308 , Coords263_g83308 , WorldPosition263_g83308 , WorldNormal263_g83308 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8687_g83242 = localSamplePlanar2D238_g83308;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8687_g83242 = localSamplePlanar3D246_g83308;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8687_g83242 = localSampleStochastic2D234_g83308;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8687_g83242 = localSampleStochastic3D263_g83308;
				#else
				float4 staticSwitch8687_g83242 = localSamplePlanar2D238_g83308;
				#endif
				half4 Layer237_g83263 = staticSwitch8687_g83242;
				TEXTURE2D(Texture238_g83309) = _NormalTex7;
				SamplerState Sampler238_g83309 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83309 = Input_Coords_078752_g83242;
				half4 Coords238_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition238_g83309 = ase_worldPos;
				half4 localSamplePlanar2D238_g83309 = SamplePlanar2D( Texture238_g83309 , Sampler238_g83309 , Coords238_g83309 , WorldPosition238_g83309 );
				TEXTURE2D(Texture246_g83309) = _NormalTex7;
				SamplerState Sampler246_g83309 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition246_g83309 = ase_worldPos;
				half3 WorldNormal246_g83309 = normalWS;
				half4 localSamplePlanar3D246_g83309 = SamplePlanar3D( Texture246_g83309 , Sampler246_g83309 , Coords246_g83309 , WorldPosition246_g83309 , WorldNormal246_g83309 );
				TEXTURE2D(Texture234_g83309) = _NormalTex7;
				SamplerState Sampler234_g83309 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83309 = temp_output_37_0_g83309;
				float3 WorldPosition234_g83309 = ase_worldPos;
				float4 localSampleStochastic2D234_g83309 = SampleStochastic2D( Texture234_g83309 , Sampler234_g83309 , Coords234_g83309 , WorldPosition234_g83309 );
				TEXTURE2D(Texture263_g83309) = _NormalTex7;
				SamplerState Sampler263_g83309 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition263_g83309 = ase_worldPos;
				half3 WorldNormal263_g83309 = normalWS;
				half4 localSampleStochastic3D263_g83309 = SampleStochastic3D( Texture263_g83309 , Sampler263_g83309 , Coords263_g83309 , WorldPosition263_g83309 , WorldNormal263_g83309 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8688_g83242 = localSamplePlanar2D238_g83309;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8688_g83242 = localSamplePlanar3D246_g83309;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8688_g83242 = localSampleStochastic2D234_g83309;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8688_g83242 = localSampleStochastic3D263_g83309;
				#else
				float4 staticSwitch8688_g83242 = localSamplePlanar2D238_g83309;
				#endif
				half4 Layer338_g83263 = staticSwitch8688_g83242;
				TEXTURE2D(Texture238_g83310) = _NormalTex8;
				SamplerState Sampler238_g83310 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83310 = Input_Coords_088749_g83242;
				half4 Coords238_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition238_g83310 = ase_worldPos;
				half4 localSamplePlanar2D238_g83310 = SamplePlanar2D( Texture238_g83310 , Sampler238_g83310 , Coords238_g83310 , WorldPosition238_g83310 );
				TEXTURE2D(Texture246_g83310) = _NormalTex8;
				SamplerState Sampler246_g83310 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition246_g83310 = ase_worldPos;
				half3 WorldNormal246_g83310 = normalWS;
				half4 localSamplePlanar3D246_g83310 = SamplePlanar3D( Texture246_g83310 , Sampler246_g83310 , Coords246_g83310 , WorldPosition246_g83310 , WorldNormal246_g83310 );
				TEXTURE2D(Texture234_g83310) = _NormalTex8;
				SamplerState Sampler234_g83310 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83310 = temp_output_37_0_g83310;
				float3 WorldPosition234_g83310 = ase_worldPos;
				float4 localSampleStochastic2D234_g83310 = SampleStochastic2D( Texture234_g83310 , Sampler234_g83310 , Coords234_g83310 , WorldPosition234_g83310 );
				TEXTURE2D(Texture263_g83310) = _NormalTex8;
				SamplerState Sampler263_g83310 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition263_g83310 = ase_worldPos;
				half3 WorldNormal263_g83310 = normalWS;
				half4 localSampleStochastic3D263_g83310 = SampleStochastic3D( Texture263_g83310 , Sampler263_g83310 , Coords263_g83310 , WorldPosition263_g83310 , WorldNormal263_g83310 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8689_g83242 = localSamplePlanar2D238_g83310;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8689_g83242 = localSamplePlanar3D246_g83310;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8689_g83242 = localSampleStochastic2D234_g83310;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8689_g83242 = localSampleStochastic3D263_g83310;
				#else
				float4 staticSwitch8689_g83242 = localSamplePlanar2D238_g83310;
				#endif
				half4 Layer439_g83263 = staticSwitch8689_g83242;
				float4 weightedBlendVar31_g83263 = Weights52_g83263;
				float4 weightedBlend31_g83263 = ( weightedBlendVar31_g83263.x*Layer133_g83263 + weightedBlendVar31_g83263.y*Layer237_g83263 + weightedBlendVar31_g83263.z*Layer338_g83263 + weightedBlendVar31_g83263.w*Layer439_g83263 );
				half4 Terrain_Normal_088684_g83242 = weightedBlend31_g83263;
				half4 Layer_0810_g83257 = Terrain_Normal_088684_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8794_g83242 = weights_127362_g83242;
				#else
				float4 staticSwitch8794_g83242 = control_127362_g83242;
				#endif
				half4 Terrain_Weights_127710_g83242 = staticSwitch8794_g83242;
				half4 Weights52_g83273 = Terrain_Weights_127710_g83242;
				TEXTURE2D(Texture238_g83319) = _NormalTex9;
				SamplerState Sampler238_g83319 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83319 = Input_Coords_098833_g83242;
				half4 Coords238_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition238_g83319 = ase_worldPos;
				half4 localSamplePlanar2D238_g83319 = SamplePlanar2D( Texture238_g83319 , Sampler238_g83319 , Coords238_g83319 , WorldPosition238_g83319 );
				TEXTURE2D(Texture246_g83319) = _NormalTex9;
				SamplerState Sampler246_g83319 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition246_g83319 = ase_worldPos;
				half3 WorldNormal246_g83319 = normalWS;
				half4 localSamplePlanar3D246_g83319 = SamplePlanar3D( Texture246_g83319 , Sampler246_g83319 , Coords246_g83319 , WorldPosition246_g83319 , WorldNormal246_g83319 );
				TEXTURE2D(Texture234_g83319) = _NormalTex9;
				SamplerState Sampler234_g83319 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83319 = temp_output_37_0_g83319;
				float3 WorldPosition234_g83319 = ase_worldPos;
				float4 localSampleStochastic2D234_g83319 = SampleStochastic2D( Texture234_g83319 , Sampler234_g83319 , Coords234_g83319 , WorldPosition234_g83319 );
				TEXTURE2D(Texture263_g83319) = _NormalTex9;
				SamplerState Sampler263_g83319 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition263_g83319 = ase_worldPos;
				half3 WorldNormal263_g83319 = normalWS;
				half4 localSampleStochastic3D263_g83319 = SampleStochastic3D( Texture263_g83319 , Sampler263_g83319 , Coords263_g83319 , WorldPosition263_g83319 , WorldNormal263_g83319 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8849_g83242 = localSamplePlanar2D238_g83319;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8849_g83242 = localSamplePlanar3D246_g83319;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8849_g83242 = localSampleStochastic2D234_g83319;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8849_g83242 = localSampleStochastic3D263_g83319;
				#else
				float4 staticSwitch8849_g83242 = localSamplePlanar2D238_g83319;
				#endif
				half4 Layer133_g83273 = staticSwitch8849_g83242;
				TEXTURE2D(Texture238_g83320) = _NormalTex10;
				SamplerState Sampler238_g83320 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83320 = Input_Coords_108834_g83242;
				half4 Coords238_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition238_g83320 = ase_worldPos;
				half4 localSamplePlanar2D238_g83320 = SamplePlanar2D( Texture238_g83320 , Sampler238_g83320 , Coords238_g83320 , WorldPosition238_g83320 );
				TEXTURE2D(Texture246_g83320) = _NormalTex10;
				SamplerState Sampler246_g83320 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition246_g83320 = ase_worldPos;
				half3 WorldNormal246_g83320 = normalWS;
				half4 localSamplePlanar3D246_g83320 = SamplePlanar3D( Texture246_g83320 , Sampler246_g83320 , Coords246_g83320 , WorldPosition246_g83320 , WorldNormal246_g83320 );
				TEXTURE2D(Texture234_g83320) = _NormalTex10;
				SamplerState Sampler234_g83320 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83320 = temp_output_37_0_g83320;
				float3 WorldPosition234_g83320 = ase_worldPos;
				float4 localSampleStochastic2D234_g83320 = SampleStochastic2D( Texture234_g83320 , Sampler234_g83320 , Coords234_g83320 , WorldPosition234_g83320 );
				TEXTURE2D(Texture263_g83320) = _NormalTex10;
				SamplerState Sampler263_g83320 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition263_g83320 = ase_worldPos;
				half3 WorldNormal263_g83320 = normalWS;
				half4 localSampleStochastic3D263_g83320 = SampleStochastic3D( Texture263_g83320 , Sampler263_g83320 , Coords263_g83320 , WorldPosition263_g83320 , WorldNormal263_g83320 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8876_g83242 = localSamplePlanar2D238_g83320;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8876_g83242 = localSamplePlanar3D246_g83320;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8876_g83242 = localSampleStochastic2D234_g83320;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8876_g83242 = localSampleStochastic3D263_g83320;
				#else
				float4 staticSwitch8876_g83242 = localSamplePlanar2D238_g83320;
				#endif
				half4 Layer237_g83273 = staticSwitch8876_g83242;
				TEXTURE2D(Texture238_g83321) = _NormalTex11;
				SamplerState Sampler238_g83321 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83321 = Input_Coords_118835_g83242;
				half4 Coords238_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition238_g83321 = ase_worldPos;
				half4 localSamplePlanar2D238_g83321 = SamplePlanar2D( Texture238_g83321 , Sampler238_g83321 , Coords238_g83321 , WorldPosition238_g83321 );
				TEXTURE2D(Texture246_g83321) = _NormalTex11;
				SamplerState Sampler246_g83321 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition246_g83321 = ase_worldPos;
				half3 WorldNormal246_g83321 = normalWS;
				half4 localSamplePlanar3D246_g83321 = SamplePlanar3D( Texture246_g83321 , Sampler246_g83321 , Coords246_g83321 , WorldPosition246_g83321 , WorldNormal246_g83321 );
				TEXTURE2D(Texture234_g83321) = _NormalTex11;
				SamplerState Sampler234_g83321 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83321 = temp_output_37_0_g83321;
				float3 WorldPosition234_g83321 = ase_worldPos;
				float4 localSampleStochastic2D234_g83321 = SampleStochastic2D( Texture234_g83321 , Sampler234_g83321 , Coords234_g83321 , WorldPosition234_g83321 );
				TEXTURE2D(Texture263_g83321) = _NormalTex11;
				SamplerState Sampler263_g83321 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition263_g83321 = ase_worldPos;
				half3 WorldNormal263_g83321 = normalWS;
				half4 localSampleStochastic3D263_g83321 = SampleStochastic3D( Texture263_g83321 , Sampler263_g83321 , Coords263_g83321 , WorldPosition263_g83321 , WorldNormal263_g83321 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8850_g83242 = localSamplePlanar2D238_g83321;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8850_g83242 = localSamplePlanar3D246_g83321;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8850_g83242 = localSampleStochastic2D234_g83321;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8850_g83242 = localSampleStochastic3D263_g83321;
				#else
				float4 staticSwitch8850_g83242 = localSamplePlanar2D238_g83321;
				#endif
				half4 Layer338_g83273 = staticSwitch8850_g83242;
				TEXTURE2D(Texture238_g83322) = _NormalTex12;
				SamplerState Sampler238_g83322 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83322 = Input_Coords_128836_g83242;
				half4 Coords238_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition238_g83322 = ase_worldPos;
				half4 localSamplePlanar2D238_g83322 = SamplePlanar2D( Texture238_g83322 , Sampler238_g83322 , Coords238_g83322 , WorldPosition238_g83322 );
				TEXTURE2D(Texture246_g83322) = _NormalTex12;
				SamplerState Sampler246_g83322 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition246_g83322 = ase_worldPos;
				half3 WorldNormal246_g83322 = normalWS;
				half4 localSamplePlanar3D246_g83322 = SamplePlanar3D( Texture246_g83322 , Sampler246_g83322 , Coords246_g83322 , WorldPosition246_g83322 , WorldNormal246_g83322 );
				TEXTURE2D(Texture234_g83322) = _NormalTex12;
				SamplerState Sampler234_g83322 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83322 = temp_output_37_0_g83322;
				float3 WorldPosition234_g83322 = ase_worldPos;
				float4 localSampleStochastic2D234_g83322 = SampleStochastic2D( Texture234_g83322 , Sampler234_g83322 , Coords234_g83322 , WorldPosition234_g83322 );
				TEXTURE2D(Texture263_g83322) = _NormalTex12;
				SamplerState Sampler263_g83322 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition263_g83322 = ase_worldPos;
				half3 WorldNormal263_g83322 = normalWS;
				half4 localSampleStochastic3D263_g83322 = SampleStochastic3D( Texture263_g83322 , Sampler263_g83322 , Coords263_g83322 , WorldPosition263_g83322 , WorldNormal263_g83322 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8877_g83242 = localSamplePlanar2D238_g83322;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8877_g83242 = localSamplePlanar3D246_g83322;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8877_g83242 = localSampleStochastic2D234_g83322;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8877_g83242 = localSampleStochastic3D263_g83322;
				#else
				float4 staticSwitch8877_g83242 = localSamplePlanar2D238_g83322;
				#endif
				half4 Layer439_g83273 = staticSwitch8877_g83242;
				float4 weightedBlendVar31_g83273 = Weights52_g83273;
				float4 weightedBlend31_g83273 = ( weightedBlendVar31_g83273.x*Layer133_g83273 + weightedBlendVar31_g83273.y*Layer237_g83273 + weightedBlendVar31_g83273.z*Layer338_g83273 + weightedBlendVar31_g83273.w*Layer439_g83273 );
				half4 Terrain_Normal_128865_g83242 = weightedBlend31_g83273;
				half4 Layer_1243_g83257 = Terrain_Normal_128865_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8795_g83242 = weights_167362_g83242;
				#else
				float4 staticSwitch8795_g83242 = control_167362_g83242;
				#endif
				half4 Terrain_Weights_167709_g83242 = staticSwitch8795_g83242;
				half4 Weights52_g83283 = Terrain_Weights_167709_g83242;
				TEXTURE2D(Texture238_g83338) = _NormalTex13;
				SamplerState Sampler238_g83338 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83338 = Input_Coords_138960_g83242;
				half4 Coords238_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition238_g83338 = ase_worldPos;
				half4 localSamplePlanar2D238_g83338 = SamplePlanar2D( Texture238_g83338 , Sampler238_g83338 , Coords238_g83338 , WorldPosition238_g83338 );
				TEXTURE2D(Texture246_g83338) = _NormalTex13;
				SamplerState Sampler246_g83338 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition246_g83338 = ase_worldPos;
				half3 WorldNormal246_g83338 = normalWS;
				half4 localSamplePlanar3D246_g83338 = SamplePlanar3D( Texture246_g83338 , Sampler246_g83338 , Coords246_g83338 , WorldPosition246_g83338 , WorldNormal246_g83338 );
				TEXTURE2D(Texture234_g83338) = _NormalTex13;
				SamplerState Sampler234_g83338 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83338 = temp_output_37_0_g83338;
				float3 WorldPosition234_g83338 = ase_worldPos;
				float4 localSampleStochastic2D234_g83338 = SampleStochastic2D( Texture234_g83338 , Sampler234_g83338 , Coords234_g83338 , WorldPosition234_g83338 );
				TEXTURE2D(Texture263_g83338) = _NormalTex13;
				SamplerState Sampler263_g83338 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition263_g83338 = ase_worldPos;
				half3 WorldNormal263_g83338 = normalWS;
				half4 localSampleStochastic3D263_g83338 = SampleStochastic3D( Texture263_g83338 , Sampler263_g83338 , Coords263_g83338 , WorldPosition263_g83338 , WorldNormal263_g83338 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch8991_g83242 = localSamplePlanar2D238_g83338;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch8991_g83242 = localSamplePlanar3D246_g83338;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch8991_g83242 = localSampleStochastic2D234_g83338;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch8991_g83242 = localSampleStochastic3D263_g83338;
				#else
				float4 staticSwitch8991_g83242 = localSamplePlanar2D238_g83338;
				#endif
				half4 Layer133_g83283 = staticSwitch8991_g83242;
				TEXTURE2D(Texture238_g83331) = _NormalTex14;
				SamplerState Sampler238_g83331 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83331 = Input_Coords_148961_g83242;
				half4 Coords238_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition238_g83331 = ase_worldPos;
				half4 localSamplePlanar2D238_g83331 = SamplePlanar2D( Texture238_g83331 , Sampler238_g83331 , Coords238_g83331 , WorldPosition238_g83331 );
				TEXTURE2D(Texture246_g83331) = _NormalTex14;
				SamplerState Sampler246_g83331 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition246_g83331 = ase_worldPos;
				half3 WorldNormal246_g83331 = normalWS;
				half4 localSamplePlanar3D246_g83331 = SamplePlanar3D( Texture246_g83331 , Sampler246_g83331 , Coords246_g83331 , WorldPosition246_g83331 , WorldNormal246_g83331 );
				TEXTURE2D(Texture234_g83331) = _NormalTex14;
				SamplerState Sampler234_g83331 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83331 = temp_output_37_0_g83331;
				float3 WorldPosition234_g83331 = ase_worldPos;
				float4 localSampleStochastic2D234_g83331 = SampleStochastic2D( Texture234_g83331 , Sampler234_g83331 , Coords234_g83331 , WorldPosition234_g83331 );
				TEXTURE2D(Texture263_g83331) = _NormalTex14;
				SamplerState Sampler263_g83331 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition263_g83331 = ase_worldPos;
				half3 WorldNormal263_g83331 = normalWS;
				half4 localSampleStochastic3D263_g83331 = SampleStochastic3D( Texture263_g83331 , Sampler263_g83331 , Coords263_g83331 , WorldPosition263_g83331 , WorldNormal263_g83331 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch8990_g83242 = localSamplePlanar2D238_g83331;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch8990_g83242 = localSamplePlanar3D246_g83331;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch8990_g83242 = localSampleStochastic2D234_g83331;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch8990_g83242 = localSampleStochastic3D263_g83331;
				#else
				float4 staticSwitch8990_g83242 = localSamplePlanar2D238_g83331;
				#endif
				half4 Layer237_g83283 = staticSwitch8990_g83242;
				TEXTURE2D(Texture238_g83332) = _NormalTex15;
				SamplerState Sampler238_g83332 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83332 = Input_Coords_158962_g83242;
				half4 Coords238_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition238_g83332 = ase_worldPos;
				half4 localSamplePlanar2D238_g83332 = SamplePlanar2D( Texture238_g83332 , Sampler238_g83332 , Coords238_g83332 , WorldPosition238_g83332 );
				TEXTURE2D(Texture246_g83332) = _NormalTex15;
				SamplerState Sampler246_g83332 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition246_g83332 = ase_worldPos;
				half3 WorldNormal246_g83332 = normalWS;
				half4 localSamplePlanar3D246_g83332 = SamplePlanar3D( Texture246_g83332 , Sampler246_g83332 , Coords246_g83332 , WorldPosition246_g83332 , WorldNormal246_g83332 );
				TEXTURE2D(Texture234_g83332) = _NormalTex15;
				SamplerState Sampler234_g83332 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83332 = temp_output_37_0_g83332;
				float3 WorldPosition234_g83332 = ase_worldPos;
				float4 localSampleStochastic2D234_g83332 = SampleStochastic2D( Texture234_g83332 , Sampler234_g83332 , Coords234_g83332 , WorldPosition234_g83332 );
				TEXTURE2D(Texture263_g83332) = _NormalTex15;
				SamplerState Sampler263_g83332 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition263_g83332 = ase_worldPos;
				half3 WorldNormal263_g83332 = normalWS;
				half4 localSampleStochastic3D263_g83332 = SampleStochastic3D( Texture263_g83332 , Sampler263_g83332 , Coords263_g83332 , WorldPosition263_g83332 , WorldNormal263_g83332 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch8989_g83242 = localSamplePlanar2D238_g83332;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch8989_g83242 = localSamplePlanar3D246_g83332;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch8989_g83242 = localSampleStochastic2D234_g83332;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch8989_g83242 = localSampleStochastic3D263_g83332;
				#else
				float4 staticSwitch8989_g83242 = localSamplePlanar2D238_g83332;
				#endif
				half4 Layer338_g83283 = staticSwitch8989_g83242;
				TEXTURE2D(Texture238_g83333) = _NormalTex16;
				SamplerState Sampler238_g83333 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83333 = Input_Coords_168959_g83242;
				half4 Coords238_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition238_g83333 = ase_worldPos;
				half4 localSamplePlanar2D238_g83333 = SamplePlanar2D( Texture238_g83333 , Sampler238_g83333 , Coords238_g83333 , WorldPosition238_g83333 );
				TEXTURE2D(Texture246_g83333) = _NormalTex16;
				SamplerState Sampler246_g83333 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition246_g83333 = ase_worldPos;
				half3 WorldNormal246_g83333 = normalWS;
				half4 localSamplePlanar3D246_g83333 = SamplePlanar3D( Texture246_g83333 , Sampler246_g83333 , Coords246_g83333 , WorldPosition246_g83333 , WorldNormal246_g83333 );
				TEXTURE2D(Texture234_g83333) = _NormalTex16;
				SamplerState Sampler234_g83333 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83333 = temp_output_37_0_g83333;
				float3 WorldPosition234_g83333 = ase_worldPos;
				float4 localSampleStochastic2D234_g83333 = SampleStochastic2D( Texture234_g83333 , Sampler234_g83333 , Coords234_g83333 , WorldPosition234_g83333 );
				TEXTURE2D(Texture263_g83333) = _NormalTex16;
				SamplerState Sampler263_g83333 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition263_g83333 = ase_worldPos;
				half3 WorldNormal263_g83333 = normalWS;
				half4 localSampleStochastic3D263_g83333 = SampleStochastic3D( Texture263_g83333 , Sampler263_g83333 , Coords263_g83333 , WorldPosition263_g83333 , WorldNormal263_g83333 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch8988_g83242 = localSamplePlanar2D238_g83333;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch8988_g83242 = localSamplePlanar3D246_g83333;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch8988_g83242 = localSampleStochastic2D234_g83333;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch8988_g83242 = localSampleStochastic3D263_g83333;
				#else
				float4 staticSwitch8988_g83242 = localSamplePlanar2D238_g83333;
				#endif
				half4 Layer439_g83283 = staticSwitch8988_g83242;
				float4 weightedBlendVar31_g83283 = Weights52_g83283;
				float4 weightedBlend31_g83283 = ( weightedBlendVar31_g83283.x*Layer133_g83283 + weightedBlendVar31_g83283.y*Layer237_g83283 + weightedBlendVar31_g83283.z*Layer338_g83283 + weightedBlendVar31_g83283.w*Layer439_g83283 );
				half4 Terrain_Normal_168987_g83242 = weightedBlend31_g83283;
				half4 Layer_1644_g83257 = Terrain_Normal_168987_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83257 = Layer_045_g83257;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 + Layer_1243_g83257 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 + Layer_1243_g83257 + Layer_1644_g83257 );
				#else
				float4 staticSwitch40_g83257 = Layer_045_g83257;
				#endif
				half4 Blend_Normal7512_g83242 = staticSwitch40_g83257;
				half4 Normal_Packed45_g83244 = Blend_Normal7512_g83242;
				float2 appendResult58_g83244 = (float2(( (Normal_Packed45_g83244).x * (Normal_Packed45_g83244).w ) , (Normal_Packed45_g83244).y));
				half2 Normal_Default50_g83244 = appendResult58_g83244;
				half2 Normal_ASTC41_g83244 = (Normal_Packed45_g83244).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g83244 = Normal_ASTC41_g83244;
				#else
				float2 staticSwitch38_g83244 = Normal_Default50_g83244;
				#endif
				half2 Normal_NO_DTX544_g83244 = (Normal_Packed45_g83244).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g83244 = Normal_NO_DTX544_g83244;
				#else
				float2 staticSwitch37_g83244 = staticSwitch38_g83244;
				#endif
				half4 Weights52_g83249 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83249 = temp_output_6970_0_g83242;
				half4 Layer237_g83249 = temp_output_6977_0_g83242;
				half4 Layer338_g83249 = temp_output_6978_0_g83242;
				half4 Layer439_g83249 = temp_output_6983_0_g83242;
				float4 weightedBlendVar31_g83249 = Weights52_g83249;
				float4 weightedBlend31_g83249 = ( weightedBlendVar31_g83249.x*Layer133_g83249 + weightedBlendVar31_g83249.y*Layer237_g83249 + weightedBlendVar31_g83249.z*Layer338_g83249 + weightedBlendVar31_g83249.w*Layer439_g83249 );
				half4 Terrain_Masks_047203_g83242 = weightedBlend31_g83249;
				half4 Layer_045_g83259 = Terrain_Masks_047203_g83242;
				half4 Weights52_g83266 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83266 = temp_output_8714_0_g83242;
				half4 Layer237_g83266 = temp_output_8721_0_g83242;
				half4 Layer338_g83266 = temp_output_8724_0_g83242;
				half4 Layer439_g83266 = temp_output_8727_0_g83242;
				float4 weightedBlendVar31_g83266 = Weights52_g83266;
				float4 weightedBlend31_g83266 = ( weightedBlendVar31_g83266.x*Layer133_g83266 + weightedBlendVar31_g83266.y*Layer237_g83266 + weightedBlendVar31_g83266.z*Layer338_g83266 + weightedBlendVar31_g83266.w*Layer439_g83266 );
				half4 Terrain_Masks_088730_g83242 = weightedBlend31_g83266;
				half4 Layer_0810_g83259 = Terrain_Masks_088730_g83242;
				half4 Weights52_g83276 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83276 = temp_output_8815_0_g83242;
				half4 Layer237_g83276 = temp_output_8818_0_g83242;
				half4 Layer338_g83276 = temp_output_8819_0_g83242;
				half4 Layer439_g83276 = temp_output_8820_0_g83242;
				float4 weightedBlendVar31_g83276 = Weights52_g83276;
				float4 weightedBlend31_g83276 = ( weightedBlendVar31_g83276.x*Layer133_g83276 + weightedBlendVar31_g83276.y*Layer237_g83276 + weightedBlendVar31_g83276.z*Layer338_g83276 + weightedBlendVar31_g83276.w*Layer439_g83276 );
				half4 Terrain_Masks_128871_g83242 = weightedBlend31_g83276;
				half4 Layer_1243_g83259 = Terrain_Masks_128871_g83242;
				half4 Weights52_g83286 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83286 = temp_output_8931_0_g83242;
				half4 Layer237_g83286 = temp_output_8934_0_g83242;
				half4 Layer338_g83286 = temp_output_8935_0_g83242;
				half4 Layer439_g83286 = temp_output_8936_0_g83242;
				float4 weightedBlendVar31_g83286 = Weights52_g83286;
				float4 weightedBlend31_g83286 = ( weightedBlendVar31_g83286.x*Layer133_g83286 + weightedBlendVar31_g83286.y*Layer237_g83286 + weightedBlendVar31_g83286.z*Layer338_g83286 + weightedBlendVar31_g83286.w*Layer439_g83286 );
				half4 Terrain_Masks_169014_g83242 = weightedBlend31_g83286;
				half4 Layer_1644_g83259 = Terrain_Masks_169014_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83259 = Layer_045_g83259;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 + Layer_1243_g83259 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 + Layer_1243_g83259 + Layer_1644_g83259 );
				#else
				float4 staticSwitch40_g83259 = Layer_045_g83259;
				#endif
				half4 Blend_Masks7420_g83242 = staticSwitch40_g83259;
				half4 Normal_Packed45_g83243 = Blend_Masks7420_g83242;
				half2 Normal_NO_DTX544_g83243 = (Normal_Packed45_g83243).wy;
				#ifdef TVE_PACKED_TEX
				float2 staticSwitch8562_g83242 = (Normal_NO_DTX544_g83243*2.0 + -1.0);
				#else
				float2 staticSwitch8562_g83242 = (staticSwitch37_g83244*2.0 + -1.0);
				#endif
				half4 Weights52_g83253 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83253 = _Params1;
				half4 Layer237_g83253 = _Params2;
				half4 Layer338_g83253 = _Params3;
				half4 Layer439_g83253 = _Params4;
				float4 weightedBlendVar31_g83253 = Weights52_g83253;
				float4 weightedBlend31_g83253 = ( weightedBlendVar31_g83253.x*Layer133_g83253 + weightedBlendVar31_g83253.y*Layer237_g83253 + weightedBlendVar31_g83253.z*Layer338_g83253 + weightedBlendVar31_g83253.w*Layer439_g83253 );
				half4 Terrain_Params_047533_g83242 = weightedBlend31_g83253;
				half4 Layer_045_g83260 = Terrain_Params_047533_g83242;
				half4 Weights52_g83270 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83270 = _Params5;
				half4 Layer237_g83270 = _Params6;
				half4 Layer338_g83270 = _Params7;
				half4 Layer439_g83270 = _Params8;
				float4 weightedBlendVar31_g83270 = Weights52_g83270;
				float4 weightedBlend31_g83270 = ( weightedBlendVar31_g83270.x*Layer133_g83270 + weightedBlendVar31_g83270.y*Layer237_g83270 + weightedBlendVar31_g83270.z*Layer338_g83270 + weightedBlendVar31_g83270.w*Layer439_g83270 );
				half4 Terrain_Params_088739_g83242 = weightedBlend31_g83270;
				half4 Layer_0810_g83260 = Terrain_Params_088739_g83242;
				half4 Weights52_g83280 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83280 = _Params9;
				half4 Layer237_g83280 = _Params10;
				half4 Layer338_g83280 = _Params11;
				half4 Layer439_g83280 = _Params12;
				float4 weightedBlendVar31_g83280 = Weights52_g83280;
				float4 weightedBlend31_g83280 = ( weightedBlendVar31_g83280.x*Layer133_g83280 + weightedBlendVar31_g83280.y*Layer237_g83280 + weightedBlendVar31_g83280.z*Layer338_g83280 + weightedBlendVar31_g83280.w*Layer439_g83280 );
				half4 Terrain_Params_128867_g83242 = weightedBlend31_g83280;
				half4 Layer_1243_g83260 = Terrain_Params_128867_g83242;
				half4 Weights52_g83290 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83290 = _Params13;
				half4 Layer237_g83290 = _Params14;
				half4 Layer338_g83290 = _Params15;
				half4 Layer439_g83290 = _Params16;
				float4 weightedBlendVar31_g83290 = Weights52_g83290;
				float4 weightedBlend31_g83290 = ( weightedBlendVar31_g83290.x*Layer133_g83290 + weightedBlendVar31_g83290.y*Layer237_g83290 + weightedBlendVar31_g83290.z*Layer338_g83290 + weightedBlendVar31_g83290.w*Layer439_g83290 );
				half4 Terrain_Params_169017_g83242 = weightedBlend31_g83290;
				half4 Layer_1644_g83260 = Terrain_Params_169017_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83260 = Layer_045_g83260;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 + Layer_1243_g83260 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 + Layer_1243_g83260 + Layer_1644_g83260 );
				#else
				float4 staticSwitch40_g83260 = Layer_045_g83260;
				#endif
				half4 Blend_Params7547_g83242 = staticSwitch40_g83260;
				half2 Normal_Planar45_g83246 = ( staticSwitch8562_g83242 * (Blend_Params7547_g83242).z );
				float2 break64_g83246 = Normal_Planar45_g83246;
				float3 appendResult65_g83246 = (float3(break64_g83246.x , 0.0 , break64_g83246.y));
				half2 Terrain_Normal6871_g79798 = (mul( ase_worldToTangent, appendResult65_g83246 )).xy;
				float2 temp_output_7045_0_g79798 = ( Terrain_Normal6871_g79798 * _TerrainNormalValue );
				half2 Blend_Normal312_g79798 = temp_output_7045_0_g79798;
				half Global_OverlayNormalScale6581_g79798 = TVE_OverlayNormalValue;
				float temp_output_84_0_g79816 = _LayerExtrasValue;
				float temp_output_19_0_g79820 = TVE_ExtrasUsage[(int)temp_output_84_0_g79816];
				float4 temp_output_93_19_g79816 = TVE_ExtrasCoords;
				float3 vertexToFrag7344_g79798 = packedInput.ase_texcoord5.xyz;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV96_g79816 = ( (temp_output_93_19_g79816).zw + ( (temp_output_93_19_g79816).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode48_g79816 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g79816,temp_output_84_0_g79816, 0.0 );
				float4 temp_output_17_0_g79820 = tex2DArrayNode48_g79816;
				float4 temp_output_94_85_g79816 = TVE_ExtrasParams;
				float4 temp_output_3_0_g79820 = temp_output_94_85_g79816;
				float4 ifLocalVar18_g79820 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79820 >= 0.5 )
				ifLocalVar18_g79820 = temp_output_17_0_g79820;
				else
				ifLocalVar18_g79820 = temp_output_3_0_g79820;
				float4 lerpResult22_g79820 = lerp( temp_output_3_0_g79820 , temp_output_17_0_g79820 , temp_output_19_0_g79820);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79820 = lerpResult22_g79820;
				#else
				float4 staticSwitch24_g79820 = ifLocalVar18_g79820;
				#endif
				half4 Global_Extras_Params5440_g79798 = staticSwitch24_g79820;
				float4 break456_g79805 = Global_Extras_Params5440_g79798;
				half Global_Extras_Overlay156_g79798 = break456_g79805.z;
				half Overlay_Value5738_g79798 = ( _GlobalOverlay * Global_Extras_Overlay156_g79798 );
				float3 appendResult7219_g79798 = (float3(temp_output_7045_0_g79798 , 1.0));
				float3 tanToWorld0 = float3( tangentWS.xyz.x, ase_worldBitangent.x, normalWS.x );
				float3 tanToWorld1 = float3( tangentWS.xyz.y, ase_worldBitangent.y, normalWS.y );
				float3 tanToWorld2 = float3( tangentWS.xyz.z, ase_worldBitangent.z, normalWS.z );
				float3 tanNormal7220_g79798 = appendResult7219_g79798;
				float3 worldNormal7220_g79798 = normalize( float3(dot(tanToWorld0,tanNormal7220_g79798), dot(tanToWorld1,tanNormal7220_g79798), dot(tanToWorld2,tanNormal7220_g79798)) );
				half3 Blend_Normal_WS7221_g79798 = worldNormal7220_g79798;
				float temp_output_7222_0_g79798 = (Blend_Normal_WS7221_g79798).y;
				float lerpResult6757_g79798 = lerp( 1.0 , saturate( temp_output_7222_0_g79798 ) , _OverlayProjectionValue);
				half Overlay_Projection6081_g79798 = lerpResult6757_g79798;
				half4 Weights52_g83255 = Terrain_Weights_046781_g83242;
				TEXTURE2D(Texture238_g83339) = _AlbedoTex1;
				SamplerState Sampler238_g83339 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83339 = Input_Coords_016785_g83242;
				half4 Coords238_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition238_g83339 = ase_worldPos;
				half4 localSamplePlanar2D238_g83339 = SamplePlanar2D( Texture238_g83339 , Sampler238_g83339 , Coords238_g83339 , WorldPosition238_g83339 );
				TEXTURE2D(Texture246_g83339) = _AlbedoTex1;
				SamplerState Sampler246_g83339 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition246_g83339 = ase_worldPos;
				half3 WorldNormal246_g83339 = normalWS;
				half4 localSamplePlanar3D246_g83339 = SamplePlanar3D( Texture246_g83339 , Sampler246_g83339 , Coords246_g83339 , WorldPosition246_g83339 , WorldNormal246_g83339 );
				TEXTURE2D(Texture234_g83339) = _AlbedoTex1;
				SamplerState Sampler234_g83339 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83339 = temp_output_37_0_g83339;
				float3 WorldPosition234_g83339 = ase_worldPos;
				float4 localSampleStochastic2D234_g83339 = SampleStochastic2D( Texture234_g83339 , Sampler234_g83339 , Coords234_g83339 , WorldPosition234_g83339 );
				TEXTURE2D(Texture263_g83339) = _AlbedoTex1;
				SamplerState Sampler263_g83339 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition263_g83339 = ase_worldPos;
				half3 WorldNormal263_g83339 = normalWS;
				half4 localSampleStochastic3D263_g83339 = SampleStochastic3D( Texture263_g83339 , Sampler263_g83339 , Coords263_g83339 , WorldPosition263_g83339 , WorldNormal263_g83339 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8614_g83242 = localSamplePlanar2D238_g83339;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8614_g83242 = localSamplePlanar3D246_g83339;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8614_g83242 = localSampleStochastic2D234_g83339;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8614_g83242 = localSampleStochastic3D263_g83339;
				#else
				float4 staticSwitch8614_g83242 = localSamplePlanar2D238_g83339;
				#endif
				half4 Layer133_g83255 = staticSwitch8614_g83242;
				TEXTURE2D(Texture238_g83292) = _AlbedoTex2;
				SamplerState Sampler238_g83292 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83292 = Input_Coords_026787_g83242;
				half4 Coords238_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition238_g83292 = ase_worldPos;
				half4 localSamplePlanar2D238_g83292 = SamplePlanar2D( Texture238_g83292 , Sampler238_g83292 , Coords238_g83292 , WorldPosition238_g83292 );
				TEXTURE2D(Texture246_g83292) = _AlbedoTex2;
				SamplerState Sampler246_g83292 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition246_g83292 = ase_worldPos;
				half3 WorldNormal246_g83292 = normalWS;
				half4 localSamplePlanar3D246_g83292 = SamplePlanar3D( Texture246_g83292 , Sampler246_g83292 , Coords246_g83292 , WorldPosition246_g83292 , WorldNormal246_g83292 );
				TEXTURE2D(Texture234_g83292) = _AlbedoTex2;
				SamplerState Sampler234_g83292 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83292 = temp_output_37_0_g83292;
				float3 WorldPosition234_g83292 = ase_worldPos;
				float4 localSampleStochastic2D234_g83292 = SampleStochastic2D( Texture234_g83292 , Sampler234_g83292 , Coords234_g83292 , WorldPosition234_g83292 );
				TEXTURE2D(Texture263_g83292) = _AlbedoTex2;
				SamplerState Sampler263_g83292 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition263_g83292 = ase_worldPos;
				half3 WorldNormal263_g83292 = normalWS;
				half4 localSampleStochastic3D263_g83292 = SampleStochastic3D( Texture263_g83292 , Sampler263_g83292 , Coords263_g83292 , WorldPosition263_g83292 , WorldNormal263_g83292 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8629_g83242 = localSamplePlanar2D238_g83292;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8629_g83242 = localSamplePlanar3D246_g83292;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8629_g83242 = localSampleStochastic2D234_g83292;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8629_g83242 = localSampleStochastic3D263_g83292;
				#else
				float4 staticSwitch8629_g83242 = localSamplePlanar2D238_g83292;
				#endif
				half4 Layer237_g83255 = staticSwitch8629_g83242;
				TEXTURE2D(Texture238_g83293) = _AlbedoTex3;
				SamplerState Sampler238_g83293 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83293 = Input_Coords_036789_g83242;
				half4 Coords238_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition238_g83293 = ase_worldPos;
				half4 localSamplePlanar2D238_g83293 = SamplePlanar2D( Texture238_g83293 , Sampler238_g83293 , Coords238_g83293 , WorldPosition238_g83293 );
				TEXTURE2D(Texture246_g83293) = _AlbedoTex3;
				SamplerState Sampler246_g83293 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition246_g83293 = ase_worldPos;
				half3 WorldNormal246_g83293 = normalWS;
				half4 localSamplePlanar3D246_g83293 = SamplePlanar3D( Texture246_g83293 , Sampler246_g83293 , Coords246_g83293 , WorldPosition246_g83293 , WorldNormal246_g83293 );
				TEXTURE2D(Texture234_g83293) = _AlbedoTex3;
				SamplerState Sampler234_g83293 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83293 = temp_output_37_0_g83293;
				float3 WorldPosition234_g83293 = ase_worldPos;
				float4 localSampleStochastic2D234_g83293 = SampleStochastic2D( Texture234_g83293 , Sampler234_g83293 , Coords234_g83293 , WorldPosition234_g83293 );
				TEXTURE2D(Texture263_g83293) = _AlbedoTex3;
				SamplerState Sampler263_g83293 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition263_g83293 = ase_worldPos;
				half3 WorldNormal263_g83293 = normalWS;
				half4 localSampleStochastic3D263_g83293 = SampleStochastic3D( Texture263_g83293 , Sampler263_g83293 , Coords263_g83293 , WorldPosition263_g83293 , WorldNormal263_g83293 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8630_g83242 = localSamplePlanar2D238_g83293;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8630_g83242 = localSamplePlanar3D246_g83293;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8630_g83242 = localSampleStochastic2D234_g83293;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8630_g83242 = localSampleStochastic3D263_g83293;
				#else
				float4 staticSwitch8630_g83242 = localSamplePlanar2D238_g83293;
				#endif
				half4 Layer338_g83255 = staticSwitch8630_g83242;
				TEXTURE2D(Texture238_g83294) = _AlbedoTex4;
				SamplerState Sampler238_g83294 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83294 = Input_Coords_046791_g83242;
				half4 Coords238_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition238_g83294 = ase_worldPos;
				half4 localSamplePlanar2D238_g83294 = SamplePlanar2D( Texture238_g83294 , Sampler238_g83294 , Coords238_g83294 , WorldPosition238_g83294 );
				TEXTURE2D(Texture246_g83294) = _AlbedoTex4;
				SamplerState Sampler246_g83294 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition246_g83294 = ase_worldPos;
				half3 WorldNormal246_g83294 = normalWS;
				half4 localSamplePlanar3D246_g83294 = SamplePlanar3D( Texture246_g83294 , Sampler246_g83294 , Coords246_g83294 , WorldPosition246_g83294 , WorldNormal246_g83294 );
				TEXTURE2D(Texture234_g83294) = _AlbedoTex4;
				SamplerState Sampler234_g83294 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83294 = temp_output_37_0_g83294;
				float3 WorldPosition234_g83294 = ase_worldPos;
				float4 localSampleStochastic2D234_g83294 = SampleStochastic2D( Texture234_g83294 , Sampler234_g83294 , Coords234_g83294 , WorldPosition234_g83294 );
				TEXTURE2D(Texture263_g83294) = _AlbedoTex4;
				SamplerState Sampler263_g83294 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition263_g83294 = ase_worldPos;
				half3 WorldNormal263_g83294 = normalWS;
				half4 localSampleStochastic3D263_g83294 = SampleStochastic3D( Texture263_g83294 , Sampler263_g83294 , Coords263_g83294 , WorldPosition263_g83294 , WorldNormal263_g83294 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8631_g83242 = localSamplePlanar2D238_g83294;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8631_g83242 = localSamplePlanar3D246_g83294;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8631_g83242 = localSampleStochastic2D234_g83294;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8631_g83242 = localSampleStochastic3D263_g83294;
				#else
				float4 staticSwitch8631_g83242 = localSamplePlanar2D238_g83294;
				#endif
				half4 Layer439_g83255 = staticSwitch8631_g83242;
				float4 weightedBlendVar31_g83255 = Weights52_g83255;
				float4 weightedBlend31_g83255 = ( weightedBlendVar31_g83255.x*Layer133_g83255 + weightedBlendVar31_g83255.y*Layer237_g83255 + weightedBlendVar31_g83255.z*Layer338_g83255 + weightedBlendVar31_g83255.w*Layer439_g83255 );
				half4 Terrain_Albedo_047200_g83242 = weightedBlend31_g83255;
				half4 Layer_045_g83258 = Terrain_Albedo_047200_g83242;
				half4 Weights52_g83262 = Terrain_Weights_087340_g83242;
				TEXTURE2D(Texture238_g83303) = _AlbedoTex5;
				SamplerState Sampler238_g83303 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83303 = Input_Coords_058750_g83242;
				half4 Coords238_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition238_g83303 = ase_worldPos;
				half4 localSamplePlanar2D238_g83303 = SamplePlanar2D( Texture238_g83303 , Sampler238_g83303 , Coords238_g83303 , WorldPosition238_g83303 );
				TEXTURE2D(Texture246_g83303) = _AlbedoTex5;
				SamplerState Sampler246_g83303 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition246_g83303 = ase_worldPos;
				half3 WorldNormal246_g83303 = normalWS;
				half4 localSamplePlanar3D246_g83303 = SamplePlanar3D( Texture246_g83303 , Sampler246_g83303 , Coords246_g83303 , WorldPosition246_g83303 , WorldNormal246_g83303 );
				TEXTURE2D(Texture234_g83303) = _AlbedoTex5;
				SamplerState Sampler234_g83303 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83303 = temp_output_37_0_g83303;
				float3 WorldPosition234_g83303 = ase_worldPos;
				float4 localSampleStochastic2D234_g83303 = SampleStochastic2D( Texture234_g83303 , Sampler234_g83303 , Coords234_g83303 , WorldPosition234_g83303 );
				TEXTURE2D(Texture263_g83303) = _AlbedoTex5;
				SamplerState Sampler263_g83303 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition263_g83303 = ase_worldPos;
				half3 WorldNormal263_g83303 = normalWS;
				half4 localSampleStochastic3D263_g83303 = SampleStochastic3D( Texture263_g83303 , Sampler263_g83303 , Coords263_g83303 , WorldPosition263_g83303 , WorldNormal263_g83303 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8690_g83242 = localSamplePlanar2D238_g83303;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8690_g83242 = localSamplePlanar3D246_g83303;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8690_g83242 = localSampleStochastic2D234_g83303;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8690_g83242 = localSampleStochastic3D263_g83303;
				#else
				float4 staticSwitch8690_g83242 = localSamplePlanar2D238_g83303;
				#endif
				half4 Layer133_g83262 = staticSwitch8690_g83242;
				TEXTURE2D(Texture238_g83304) = _AlbedoTex6;
				SamplerState Sampler238_g83304 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83304 = Input_Coords_068751_g83242;
				half4 Coords238_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition238_g83304 = ase_worldPos;
				half4 localSamplePlanar2D238_g83304 = SamplePlanar2D( Texture238_g83304 , Sampler238_g83304 , Coords238_g83304 , WorldPosition238_g83304 );
				TEXTURE2D(Texture246_g83304) = _AlbedoTex6;
				SamplerState Sampler246_g83304 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition246_g83304 = ase_worldPos;
				half3 WorldNormal246_g83304 = normalWS;
				half4 localSamplePlanar3D246_g83304 = SamplePlanar3D( Texture246_g83304 , Sampler246_g83304 , Coords246_g83304 , WorldPosition246_g83304 , WorldNormal246_g83304 );
				TEXTURE2D(Texture234_g83304) = _AlbedoTex6;
				SamplerState Sampler234_g83304 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83304 = temp_output_37_0_g83304;
				float3 WorldPosition234_g83304 = ase_worldPos;
				float4 localSampleStochastic2D234_g83304 = SampleStochastic2D( Texture234_g83304 , Sampler234_g83304 , Coords234_g83304 , WorldPosition234_g83304 );
				TEXTURE2D(Texture263_g83304) = _AlbedoTex6;
				SamplerState Sampler263_g83304 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition263_g83304 = ase_worldPos;
				half3 WorldNormal263_g83304 = normalWS;
				half4 localSampleStochastic3D263_g83304 = SampleStochastic3D( Texture263_g83304 , Sampler263_g83304 , Coords263_g83304 , WorldPosition263_g83304 , WorldNormal263_g83304 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8691_g83242 = localSamplePlanar2D238_g83304;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8691_g83242 = localSamplePlanar3D246_g83304;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8691_g83242 = localSampleStochastic2D234_g83304;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8691_g83242 = localSampleStochastic3D263_g83304;
				#else
				float4 staticSwitch8691_g83242 = localSamplePlanar2D238_g83304;
				#endif
				half4 Layer237_g83262 = staticSwitch8691_g83242;
				TEXTURE2D(Texture238_g83305) = _AlbedoTex7;
				SamplerState Sampler238_g83305 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83305 = Input_Coords_078752_g83242;
				half4 Coords238_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition238_g83305 = ase_worldPos;
				half4 localSamplePlanar2D238_g83305 = SamplePlanar2D( Texture238_g83305 , Sampler238_g83305 , Coords238_g83305 , WorldPosition238_g83305 );
				TEXTURE2D(Texture246_g83305) = _AlbedoTex7;
				SamplerState Sampler246_g83305 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition246_g83305 = ase_worldPos;
				half3 WorldNormal246_g83305 = normalWS;
				half4 localSamplePlanar3D246_g83305 = SamplePlanar3D( Texture246_g83305 , Sampler246_g83305 , Coords246_g83305 , WorldPosition246_g83305 , WorldNormal246_g83305 );
				TEXTURE2D(Texture234_g83305) = _AlbedoTex7;
				SamplerState Sampler234_g83305 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83305 = temp_output_37_0_g83305;
				float3 WorldPosition234_g83305 = ase_worldPos;
				float4 localSampleStochastic2D234_g83305 = SampleStochastic2D( Texture234_g83305 , Sampler234_g83305 , Coords234_g83305 , WorldPosition234_g83305 );
				TEXTURE2D(Texture263_g83305) = _AlbedoTex7;
				SamplerState Sampler263_g83305 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition263_g83305 = ase_worldPos;
				half3 WorldNormal263_g83305 = normalWS;
				half4 localSampleStochastic3D263_g83305 = SampleStochastic3D( Texture263_g83305 , Sampler263_g83305 , Coords263_g83305 , WorldPosition263_g83305 , WorldNormal263_g83305 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8692_g83242 = localSamplePlanar2D238_g83305;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8692_g83242 = localSamplePlanar3D246_g83305;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8692_g83242 = localSampleStochastic2D234_g83305;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8692_g83242 = localSampleStochastic3D263_g83305;
				#else
				float4 staticSwitch8692_g83242 = localSamplePlanar2D238_g83305;
				#endif
				half4 Layer338_g83262 = staticSwitch8692_g83242;
				TEXTURE2D(Texture238_g83306) = _AlbedoTex8;
				SamplerState Sampler238_g83306 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83306 = Input_Coords_088749_g83242;
				half4 Coords238_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition238_g83306 = ase_worldPos;
				half4 localSamplePlanar2D238_g83306 = SamplePlanar2D( Texture238_g83306 , Sampler238_g83306 , Coords238_g83306 , WorldPosition238_g83306 );
				TEXTURE2D(Texture246_g83306) = _AlbedoTex8;
				SamplerState Sampler246_g83306 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition246_g83306 = ase_worldPos;
				half3 WorldNormal246_g83306 = normalWS;
				half4 localSamplePlanar3D246_g83306 = SamplePlanar3D( Texture246_g83306 , Sampler246_g83306 , Coords246_g83306 , WorldPosition246_g83306 , WorldNormal246_g83306 );
				TEXTURE2D(Texture234_g83306) = _AlbedoTex8;
				SamplerState Sampler234_g83306 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83306 = temp_output_37_0_g83306;
				float3 WorldPosition234_g83306 = ase_worldPos;
				float4 localSampleStochastic2D234_g83306 = SampleStochastic2D( Texture234_g83306 , Sampler234_g83306 , Coords234_g83306 , WorldPosition234_g83306 );
				TEXTURE2D(Texture263_g83306) = _AlbedoTex8;
				SamplerState Sampler263_g83306 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition263_g83306 = ase_worldPos;
				half3 WorldNormal263_g83306 = normalWS;
				half4 localSampleStochastic3D263_g83306 = SampleStochastic3D( Texture263_g83306 , Sampler263_g83306 , Coords263_g83306 , WorldPosition263_g83306 , WorldNormal263_g83306 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8693_g83242 = localSamplePlanar2D238_g83306;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8693_g83242 = localSamplePlanar3D246_g83306;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8693_g83242 = localSampleStochastic2D234_g83306;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8693_g83242 = localSampleStochastic3D263_g83306;
				#else
				float4 staticSwitch8693_g83242 = localSamplePlanar2D238_g83306;
				#endif
				half4 Layer439_g83262 = staticSwitch8693_g83242;
				float4 weightedBlendVar31_g83262 = Weights52_g83262;
				float4 weightedBlend31_g83262 = ( weightedBlendVar31_g83262.x*Layer133_g83262 + weightedBlendVar31_g83262.y*Layer237_g83262 + weightedBlendVar31_g83262.z*Layer338_g83262 + weightedBlendVar31_g83262.w*Layer439_g83262 );
				half4 Terrain_Albedo_088665_g83242 = weightedBlend31_g83262;
				half4 Layer_0810_g83258 = Terrain_Albedo_088665_g83242;
				half4 Weights52_g83272 = Terrain_Weights_127710_g83242;
				TEXTURE2D(Texture238_g83315) = _AlbedoTex9;
				SamplerState Sampler238_g83315 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83315 = Input_Coords_098833_g83242;
				half4 Coords238_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition238_g83315 = ase_worldPos;
				half4 localSamplePlanar2D238_g83315 = SamplePlanar2D( Texture238_g83315 , Sampler238_g83315 , Coords238_g83315 , WorldPosition238_g83315 );
				TEXTURE2D(Texture246_g83315) = _AlbedoTex9;
				SamplerState Sampler246_g83315 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition246_g83315 = ase_worldPos;
				half3 WorldNormal246_g83315 = normalWS;
				half4 localSamplePlanar3D246_g83315 = SamplePlanar3D( Texture246_g83315 , Sampler246_g83315 , Coords246_g83315 , WorldPosition246_g83315 , WorldNormal246_g83315 );
				TEXTURE2D(Texture234_g83315) = _AlbedoTex9;
				SamplerState Sampler234_g83315 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83315 = temp_output_37_0_g83315;
				float3 WorldPosition234_g83315 = ase_worldPos;
				float4 localSampleStochastic2D234_g83315 = SampleStochastic2D( Texture234_g83315 , Sampler234_g83315 , Coords234_g83315 , WorldPosition234_g83315 );
				TEXTURE2D(Texture263_g83315) = _AlbedoTex9;
				SamplerState Sampler263_g83315 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition263_g83315 = ase_worldPos;
				half3 WorldNormal263_g83315 = normalWS;
				half4 localSampleStochastic3D263_g83315 = SampleStochastic3D( Texture263_g83315 , Sampler263_g83315 , Coords263_g83315 , WorldPosition263_g83315 , WorldNormal263_g83315 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8872_g83242 = localSamplePlanar2D238_g83315;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8872_g83242 = localSamplePlanar3D246_g83315;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8872_g83242 = localSampleStochastic2D234_g83315;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8872_g83242 = localSampleStochastic3D263_g83315;
				#else
				float4 staticSwitch8872_g83242 = localSamplePlanar2D238_g83315;
				#endif
				half4 Layer133_g83272 = staticSwitch8872_g83242;
				TEXTURE2D(Texture238_g83316) = _AlbedoTex10;
				SamplerState Sampler238_g83316 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83316 = Input_Coords_108834_g83242;
				half4 Coords238_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition238_g83316 = ase_worldPos;
				half4 localSamplePlanar2D238_g83316 = SamplePlanar2D( Texture238_g83316 , Sampler238_g83316 , Coords238_g83316 , WorldPosition238_g83316 );
				TEXTURE2D(Texture246_g83316) = _AlbedoTex10;
				SamplerState Sampler246_g83316 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition246_g83316 = ase_worldPos;
				half3 WorldNormal246_g83316 = normalWS;
				half4 localSamplePlanar3D246_g83316 = SamplePlanar3D( Texture246_g83316 , Sampler246_g83316 , Coords246_g83316 , WorldPosition246_g83316 , WorldNormal246_g83316 );
				TEXTURE2D(Texture234_g83316) = _AlbedoTex10;
				SamplerState Sampler234_g83316 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83316 = temp_output_37_0_g83316;
				float3 WorldPosition234_g83316 = ase_worldPos;
				float4 localSampleStochastic2D234_g83316 = SampleStochastic2D( Texture234_g83316 , Sampler234_g83316 , Coords234_g83316 , WorldPosition234_g83316 );
				TEXTURE2D(Texture263_g83316) = _AlbedoTex10;
				SamplerState Sampler263_g83316 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition263_g83316 = ase_worldPos;
				half3 WorldNormal263_g83316 = normalWS;
				half4 localSampleStochastic3D263_g83316 = SampleStochastic3D( Texture263_g83316 , Sampler263_g83316 , Coords263_g83316 , WorldPosition263_g83316 , WorldNormal263_g83316 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8873_g83242 = localSamplePlanar2D238_g83316;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8873_g83242 = localSamplePlanar3D246_g83316;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8873_g83242 = localSampleStochastic2D234_g83316;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8873_g83242 = localSampleStochastic3D263_g83316;
				#else
				float4 staticSwitch8873_g83242 = localSamplePlanar2D238_g83316;
				#endif
				half4 Layer237_g83272 = staticSwitch8873_g83242;
				TEXTURE2D(Texture238_g83317) = _AlbedoTex11;
				SamplerState Sampler238_g83317 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83317 = Input_Coords_118835_g83242;
				half4 Coords238_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition238_g83317 = ase_worldPos;
				half4 localSamplePlanar2D238_g83317 = SamplePlanar2D( Texture238_g83317 , Sampler238_g83317 , Coords238_g83317 , WorldPosition238_g83317 );
				TEXTURE2D(Texture246_g83317) = _AlbedoTex11;
				SamplerState Sampler246_g83317 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition246_g83317 = ase_worldPos;
				half3 WorldNormal246_g83317 = normalWS;
				half4 localSamplePlanar3D246_g83317 = SamplePlanar3D( Texture246_g83317 , Sampler246_g83317 , Coords246_g83317 , WorldPosition246_g83317 , WorldNormal246_g83317 );
				TEXTURE2D(Texture234_g83317) = _AlbedoTex11;
				SamplerState Sampler234_g83317 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83317 = temp_output_37_0_g83317;
				float3 WorldPosition234_g83317 = ase_worldPos;
				float4 localSampleStochastic2D234_g83317 = SampleStochastic2D( Texture234_g83317 , Sampler234_g83317 , Coords234_g83317 , WorldPosition234_g83317 );
				TEXTURE2D(Texture263_g83317) = _AlbedoTex11;
				SamplerState Sampler263_g83317 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition263_g83317 = ase_worldPos;
				half3 WorldNormal263_g83317 = normalWS;
				half4 localSampleStochastic3D263_g83317 = SampleStochastic3D( Texture263_g83317 , Sampler263_g83317 , Coords263_g83317 , WorldPosition263_g83317 , WorldNormal263_g83317 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8874_g83242 = localSamplePlanar2D238_g83317;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8874_g83242 = localSamplePlanar3D246_g83317;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8874_g83242 = localSampleStochastic2D234_g83317;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8874_g83242 = localSampleStochastic3D263_g83317;
				#else
				float4 staticSwitch8874_g83242 = localSamplePlanar2D238_g83317;
				#endif
				half4 Layer338_g83272 = staticSwitch8874_g83242;
				TEXTURE2D(Texture238_g83318) = _AlbedoTex12;
				SamplerState Sampler238_g83318 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83318 = Input_Coords_128836_g83242;
				half4 Coords238_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition238_g83318 = ase_worldPos;
				half4 localSamplePlanar2D238_g83318 = SamplePlanar2D( Texture238_g83318 , Sampler238_g83318 , Coords238_g83318 , WorldPosition238_g83318 );
				TEXTURE2D(Texture246_g83318) = _AlbedoTex12;
				SamplerState Sampler246_g83318 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition246_g83318 = ase_worldPos;
				half3 WorldNormal246_g83318 = normalWS;
				half4 localSamplePlanar3D246_g83318 = SamplePlanar3D( Texture246_g83318 , Sampler246_g83318 , Coords246_g83318 , WorldPosition246_g83318 , WorldNormal246_g83318 );
				TEXTURE2D(Texture234_g83318) = _AlbedoTex12;
				SamplerState Sampler234_g83318 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83318 = temp_output_37_0_g83318;
				float3 WorldPosition234_g83318 = ase_worldPos;
				float4 localSampleStochastic2D234_g83318 = SampleStochastic2D( Texture234_g83318 , Sampler234_g83318 , Coords234_g83318 , WorldPosition234_g83318 );
				TEXTURE2D(Texture263_g83318) = _AlbedoTex12;
				SamplerState Sampler263_g83318 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition263_g83318 = ase_worldPos;
				half3 WorldNormal263_g83318 = normalWS;
				half4 localSampleStochastic3D263_g83318 = SampleStochastic3D( Texture263_g83318 , Sampler263_g83318 , Coords263_g83318 , WorldPosition263_g83318 , WorldNormal263_g83318 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8875_g83242 = localSamplePlanar2D238_g83318;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8875_g83242 = localSamplePlanar3D246_g83318;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8875_g83242 = localSampleStochastic2D234_g83318;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8875_g83242 = localSampleStochastic3D263_g83318;
				#else
				float4 staticSwitch8875_g83242 = localSamplePlanar2D238_g83318;
				#endif
				half4 Layer439_g83272 = staticSwitch8875_g83242;
				float4 weightedBlendVar31_g83272 = Weights52_g83272;
				float4 weightedBlend31_g83272 = ( weightedBlendVar31_g83272.x*Layer133_g83272 + weightedBlendVar31_g83272.y*Layer237_g83272 + weightedBlendVar31_g83272.z*Layer338_g83272 + weightedBlendVar31_g83272.w*Layer439_g83272 );
				half4 Terrain_Albedo_128851_g83242 = weightedBlend31_g83272;
				half4 Layer_1243_g83258 = Terrain_Albedo_128851_g83242;
				half4 Weights52_g83282 = Terrain_Weights_167709_g83242;
				TEXTURE2D(Texture238_g83327) = _AlbedoTex13;
				SamplerState Sampler238_g83327 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83327 = Input_Coords_138960_g83242;
				half4 Coords238_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition238_g83327 = ase_worldPos;
				half4 localSamplePlanar2D238_g83327 = SamplePlanar2D( Texture238_g83327 , Sampler238_g83327 , Coords238_g83327 , WorldPosition238_g83327 );
				TEXTURE2D(Texture246_g83327) = _AlbedoTex13;
				SamplerState Sampler246_g83327 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition246_g83327 = ase_worldPos;
				half3 WorldNormal246_g83327 = normalWS;
				half4 localSamplePlanar3D246_g83327 = SamplePlanar3D( Texture246_g83327 , Sampler246_g83327 , Coords246_g83327 , WorldPosition246_g83327 , WorldNormal246_g83327 );
				TEXTURE2D(Texture234_g83327) = _AlbedoTex13;
				SamplerState Sampler234_g83327 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83327 = temp_output_37_0_g83327;
				float3 WorldPosition234_g83327 = ase_worldPos;
				float4 localSampleStochastic2D234_g83327 = SampleStochastic2D( Texture234_g83327 , Sampler234_g83327 , Coords234_g83327 , WorldPosition234_g83327 );
				TEXTURE2D(Texture263_g83327) = _AlbedoTex13;
				SamplerState Sampler263_g83327 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition263_g83327 = ase_worldPos;
				half3 WorldNormal263_g83327 = normalWS;
				half4 localSampleStochastic3D263_g83327 = SampleStochastic3D( Texture263_g83327 , Sampler263_g83327 , Coords263_g83327 , WorldPosition263_g83327 , WorldNormal263_g83327 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch8972_g83242 = localSamplePlanar2D238_g83327;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch8972_g83242 = localSamplePlanar3D246_g83327;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch8972_g83242 = localSampleStochastic2D234_g83327;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch8972_g83242 = localSampleStochastic3D263_g83327;
				#else
				float4 staticSwitch8972_g83242 = localSamplePlanar2D238_g83327;
				#endif
				half4 Layer133_g83282 = staticSwitch8972_g83242;
				TEXTURE2D(Texture238_g83328) = _AlbedoTex14;
				SamplerState Sampler238_g83328 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83328 = Input_Coords_148961_g83242;
				half4 Coords238_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition238_g83328 = ase_worldPos;
				half4 localSamplePlanar2D238_g83328 = SamplePlanar2D( Texture238_g83328 , Sampler238_g83328 , Coords238_g83328 , WorldPosition238_g83328 );
				TEXTURE2D(Texture246_g83328) = _AlbedoTex14;
				SamplerState Sampler246_g83328 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition246_g83328 = ase_worldPos;
				half3 WorldNormal246_g83328 = normalWS;
				half4 localSamplePlanar3D246_g83328 = SamplePlanar3D( Texture246_g83328 , Sampler246_g83328 , Coords246_g83328 , WorldPosition246_g83328 , WorldNormal246_g83328 );
				TEXTURE2D(Texture234_g83328) = _AlbedoTex14;
				SamplerState Sampler234_g83328 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83328 = temp_output_37_0_g83328;
				float3 WorldPosition234_g83328 = ase_worldPos;
				float4 localSampleStochastic2D234_g83328 = SampleStochastic2D( Texture234_g83328 , Sampler234_g83328 , Coords234_g83328 , WorldPosition234_g83328 );
				TEXTURE2D(Texture263_g83328) = _AlbedoTex14;
				SamplerState Sampler263_g83328 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition263_g83328 = ase_worldPos;
				half3 WorldNormal263_g83328 = normalWS;
				half4 localSampleStochastic3D263_g83328 = SampleStochastic3D( Texture263_g83328 , Sampler263_g83328 , Coords263_g83328 , WorldPosition263_g83328 , WorldNormal263_g83328 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch8973_g83242 = localSamplePlanar2D238_g83328;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch8973_g83242 = localSamplePlanar3D246_g83328;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch8973_g83242 = localSampleStochastic2D234_g83328;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch8973_g83242 = localSampleStochastic3D263_g83328;
				#else
				float4 staticSwitch8973_g83242 = localSamplePlanar2D238_g83328;
				#endif
				half4 Layer237_g83282 = staticSwitch8973_g83242;
				TEXTURE2D(Texture238_g83329) = _AlbedoTex15;
				SamplerState Sampler238_g83329 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83329 = Input_Coords_158962_g83242;
				half4 Coords238_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition238_g83329 = ase_worldPos;
				half4 localSamplePlanar2D238_g83329 = SamplePlanar2D( Texture238_g83329 , Sampler238_g83329 , Coords238_g83329 , WorldPosition238_g83329 );
				TEXTURE2D(Texture246_g83329) = _AlbedoTex15;
				SamplerState Sampler246_g83329 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition246_g83329 = ase_worldPos;
				half3 WorldNormal246_g83329 = normalWS;
				half4 localSamplePlanar3D246_g83329 = SamplePlanar3D( Texture246_g83329 , Sampler246_g83329 , Coords246_g83329 , WorldPosition246_g83329 , WorldNormal246_g83329 );
				TEXTURE2D(Texture234_g83329) = _AlbedoTex15;
				SamplerState Sampler234_g83329 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83329 = temp_output_37_0_g83329;
				float3 WorldPosition234_g83329 = ase_worldPos;
				float4 localSampleStochastic2D234_g83329 = SampleStochastic2D( Texture234_g83329 , Sampler234_g83329 , Coords234_g83329 , WorldPosition234_g83329 );
				TEXTURE2D(Texture263_g83329) = _AlbedoTex15;
				SamplerState Sampler263_g83329 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition263_g83329 = ase_worldPos;
				half3 WorldNormal263_g83329 = normalWS;
				half4 localSampleStochastic3D263_g83329 = SampleStochastic3D( Texture263_g83329 , Sampler263_g83329 , Coords263_g83329 , WorldPosition263_g83329 , WorldNormal263_g83329 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch8974_g83242 = localSamplePlanar2D238_g83329;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch8974_g83242 = localSamplePlanar3D246_g83329;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch8974_g83242 = localSampleStochastic2D234_g83329;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch8974_g83242 = localSampleStochastic3D263_g83329;
				#else
				float4 staticSwitch8974_g83242 = localSamplePlanar2D238_g83329;
				#endif
				half4 Layer338_g83282 = staticSwitch8974_g83242;
				TEXTURE2D(Texture238_g83330) = _AlbedoTex16;
				SamplerState Sampler238_g83330 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83330 = Input_Coords_168959_g83242;
				half4 Coords238_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition238_g83330 = ase_worldPos;
				half4 localSamplePlanar2D238_g83330 = SamplePlanar2D( Texture238_g83330 , Sampler238_g83330 , Coords238_g83330 , WorldPosition238_g83330 );
				TEXTURE2D(Texture246_g83330) = _AlbedoTex16;
				SamplerState Sampler246_g83330 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition246_g83330 = ase_worldPos;
				half3 WorldNormal246_g83330 = normalWS;
				half4 localSamplePlanar3D246_g83330 = SamplePlanar3D( Texture246_g83330 , Sampler246_g83330 , Coords246_g83330 , WorldPosition246_g83330 , WorldNormal246_g83330 );
				TEXTURE2D(Texture234_g83330) = _AlbedoTex16;
				SamplerState Sampler234_g83330 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83330 = temp_output_37_0_g83330;
				float3 WorldPosition234_g83330 = ase_worldPos;
				float4 localSampleStochastic2D234_g83330 = SampleStochastic2D( Texture234_g83330 , Sampler234_g83330 , Coords234_g83330 , WorldPosition234_g83330 );
				TEXTURE2D(Texture263_g83330) = _AlbedoTex16;
				SamplerState Sampler263_g83330 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition263_g83330 = ase_worldPos;
				half3 WorldNormal263_g83330 = normalWS;
				half4 localSampleStochastic3D263_g83330 = SampleStochastic3D( Texture263_g83330 , Sampler263_g83330 , Coords263_g83330 , WorldPosition263_g83330 , WorldNormal263_g83330 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch8975_g83242 = localSamplePlanar2D238_g83330;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch8975_g83242 = localSamplePlanar3D246_g83330;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch8975_g83242 = localSampleStochastic2D234_g83330;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch8975_g83242 = localSampleStochastic3D263_g83330;
				#else
				float4 staticSwitch8975_g83242 = localSamplePlanar2D238_g83330;
				#endif
				half4 Layer439_g83282 = staticSwitch8975_g83242;
				float4 weightedBlendVar31_g83282 = Weights52_g83282;
				float4 weightedBlend31_g83282 = ( weightedBlendVar31_g83282.x*Layer133_g83282 + weightedBlendVar31_g83282.y*Layer237_g83282 + weightedBlendVar31_g83282.z*Layer338_g83282 + weightedBlendVar31_g83282.w*Layer439_g83282 );
				half4 Terrain_Albedo_168986_g83242 = weightedBlend31_g83282;
				half4 Layer_1644_g83258 = Terrain_Albedo_168986_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83258 = Layer_045_g83258;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 + Layer_1243_g83258 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 + Layer_1243_g83258 + Layer_1644_g83258 );
				#else
				float4 staticSwitch40_g83258 = Layer_045_g83258;
				#endif
				half4 Blend_Albedo7468_g83242 = staticSwitch40_g83258;
				half4 Terrain_Albedo6800_g79798 = Blend_Albedo7468_g83242;
				half3 Blend_Albedo2808_g79798 = ( (Terrain_Albedo6800_g79798).xyz * (_TerrainColor).rgb );
				float3 temp_output_3_0_g79843 = Blend_Albedo2808_g79798;
				float dotResult20_g79843 = dot( temp_output_3_0_g79843 , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Grayscale5939_g79798 = dotResult20_g79843;
				float clampResult6740_g79798 = clamp( saturate( ( Blend_Albedo_Grayscale5939_g79798 * 5.0 ) ) , 0.2 , 1.0 );
				half Blend_Albedo_Globals6410_g79798 = clampResult6740_g79798;
				half Overlay_Shading6688_g79798 = Blend_Albedo_Globals6410_g79798;
				half Overlay_Custom6707_g79798 = 1.0;
				float temp_output_7_0_g79848 = 0.1;
				float temp_output_10_0_g79848 = ( 0.2 - temp_output_7_0_g79848 );
				half Overlay_Mask_High6064_g79798 = saturate( ( ( ( Overlay_Value5738_g79798 * Overlay_Projection6081_g79798 * Overlay_Shading6688_g79798 * Overlay_Custom6707_g79798 ) - temp_output_7_0_g79848 ) / ( temp_output_10_0_g79848 + 0.0001 ) ) );
				half Overlay_Mask269_g79798 = Overlay_Mask_High6064_g79798;
				float lerpResult6585_g79798 = lerp( 1.0 , Global_OverlayNormalScale6581_g79798 , Overlay_Mask269_g79798);
				half2 Blend_Normal_Overlay366_g79798 = ( Blend_Normal312_g79798 * lerpResult6585_g79798 );
				half Global_WetnessNormalScale6571_g79798 = TVE_WetnessNormalValue;
				half Global_Extras_Wetness305_g79798 = break456_g79805.y;
				half Wetness_Value6343_g79798 = ( Global_Extras_Wetness305_g79798 * _GlobalWetness );
				float lerpResult6579_g79798 = lerp( 1.0 , Global_WetnessNormalScale6571_g79798 , ( Wetness_Value6343_g79798 * Wetness_Value6343_g79798 ));
				half2 Blend_Normal_Wetness6372_g79798 = ( Blend_Normal_Overlay366_g79798 * lerpResult6579_g79798 );
				float3 appendResult6568_g79798 = (float3(Blend_Normal_Wetness6372_g79798 , 1.0));
				
				#ifdef TVE_PACKED_TEX
				float staticSwitch8571_g83242 = 0.0;
				#else
				float staticSwitch8571_g83242 = ( (Blend_Masks7420_g83242).x * (Blend_Params7547_g83242).x );
				#endif
				#ifdef TVE_PACKED_TEX
				float staticSwitch8559_g83242 = 1.0;
				#else
				float staticSwitch8559_g83242 = (Blend_Masks7420_g83242).y;
				#endif
				#ifdef TVE_PACKED_TEX
				float staticSwitch8560_g83242 = (Blend_Masks7420_g83242).x;
				#else
				float staticSwitch8560_g83242 = (Blend_Masks7420_g83242).w;
				#endif
				float4 appendResult8574_g83242 = (float4(staticSwitch8571_g83242 , staticSwitch8559_g83242 , (Blend_Masks7420_g83242).z , ( staticSwitch8560_g83242 * (Blend_Params7547_g83242).w )));
				half4 Terrain_Masks7251_g79798 = appendResult8574_g83242;
				half Blend_Smoothness314_g79798 = ( (Terrain_Masks7251_g79798).w * _TerrainSmoothnessValue );
				half Global_OverlaySmoothness311_g79798 = TVE_OverlaySmoothness;
				float lerpResult343_g79798 = lerp( Blend_Smoothness314_g79798 , Global_OverlaySmoothness311_g79798 , Overlay_Mask269_g79798);
				half Blend_Smoothness_Overlay371_g79798 = lerpResult343_g79798;
				float temp_output_6499_0_g79798 = ( 1.0 - Wetness_Value6343_g79798 );
				half Blend_Smoothness_Wetness4130_g79798 = saturate( ( Blend_Smoothness_Overlay371_g79798 + ( 1.0 - ( temp_output_6499_0_g79798 * temp_output_6499_0_g79798 ) ) ) );
				
				float localCustomAlphaClip19_g83341 = ( 0.0 );
				half Terrain_Holes7437_g83242 = SAMPLE_TEXTURE2D( _HolesTex, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 ).r;
				half Terrain_Holes7159_g79798 = Terrain_Holes7437_g83242;
				half Global_Extras_Alpha1033_g79798 = saturate( break456_g79805.w );
				float lerpResult7479_g79798 = lerp( 1.0 , Global_Extras_Alpha1033_g79798 , _GlobalAlpha);
				half Alpha_Global7481_g79798 = lerpResult7479_g79798;
				half AlphaTreshold2132_g79798 = _AlphaClipValue;
				float temp_output_3_0_g83341 = ( ( Terrain_Holes7159_g79798 * Alpha_Global7481_g79798 ) - AlphaTreshold2132_g79798 );
				float Alpha19_g83341 = temp_output_3_0_g83341;
				float temp_output_15_0_g83341 = 0.01;
				float Treshold19_g83341 = temp_output_15_0_g83341;
				{
				#if defined (TVE_ALPHA_CLIP) || defined (TVE_ALPHA_FADE) || defined (TVE_ALPHA_GLOBAL)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#else
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#endif
				}
				
				surfaceDescription.Normal = appendResult6568_g79798;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g79798;
				surfaceDescription.Alpha = Alpha19_g83341;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

                #if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
				outputDepth = posInput.deviceDepth;
				#endif

                #if SHADERPASS == SHADERPASS_SHADOWS
                float bias = max(abs(ddx(posInput.deviceDepth)), abs(ddy(posInput.deviceDepth))) * _SlopeScaleDepthBias;
                outputDepth += bias;
                #endif

				#ifdef SCENESELECTIONPASS
    				outColor = float4(_ObjectId, _PassValue, 1.0, 1.0);
				#elif defined(SCENEPICKINGPASS)
    				outColor = unity_SelectionID;
				#else
    				#ifdef WRITE_MSAA_DEPTH
    				depthColor = packedInput.positionCS.z;
    				depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
    				#endif

    				#if defined(WRITE_NORMAL_BUFFER)
    				EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
    				#endif

    				#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
    				DecalPrepassData decalPrepassData;
    				decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
    				decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
    				EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
    				#endif

				#endif // SCENESELECTIONPASS

			}

			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="Forward" }

			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			Blend 1 SrcAlpha OneMinusSrcAlpha

			Cull [_CullModeForward]
			ZTest [_ZTestDepthEqualForOpaque]
			ZWrite [_ZWrite]

			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				Comp Always
				Pass Replace
			}


            ColorMask [_ColorMaskTransparentVelOne] 1
            ColorMask [_ColorMaskTransparentVelTwo] 2

			HLSLPROGRAM
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140011
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
			#pragma multi_compile_fragment SHADOW_LOW SHADOW_MEDIUM SHADOW_HIGH
            #pragma multi_compile_fragment AREA_SHADOW_MEDIUM AREA_SHADOW_HIGH
            #pragma multi_compile_fragment PROBE_VOLUMES_OFF PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
            #pragma multi_compile_fragment SCREEN_SPACE_SHADOWS_OFF SCREEN_SPACE_SHADOWS_ON
            #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST

            #pragma multi_compile _ DEBUG_DISPLAY
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
            #pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT

			#ifndef SHADER_STAGE_FRAGMENT
			#define SHADOW_LOW
			#define USE_FPTL_LIGHTLIST
			#endif

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_FORWARD
		    #define HAS_LIGHTLOOP 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			half4 _MaskMax8;
			half4 _Coords7;
			half4 _MaskMax6;
			half4 _MaskMin6;
			half4 _Coords6;
			half4 _MaskMax5;
			half4 _MaskMin5;
			half4 _Coords5;
			half4 _MaskMax4;
			half4 _MaskMin4;
			half4 _MaskMin7;
			half4 _Coords4;
			half4 _MaskMin3;
			half4 _Coords3;
			half4 _MaskMax2;
			half4 _MaskMin2;
			half4 _Coords2;
			half4 _MaskMax1;
			half4 _MaskMin1;
			half4 _Coords1;
			half4 _MaskMax16;
			half4 _MaskMax3;
			half4 _MaskMax7;
			half4 _Coords8;
			half4 _MaskMin8;
			half4 _MaskMin15;
			half4 _Coords15;
			half4 _MaskMax14;
			half4 _MaskMin14;
			half4 _Coords14;
			half4 _MaskMax13;
			half4 _MaskMin13;
			half4 _Coords13;
			half4 _MaskMax12;
			half4 _MaskMin12;
			half4 _Coords12;
			half4 _MaskMax11;
			half4 _MaskMin11;
			half4 _Coords11;
			half4 _MaskMax10;
			half4 _MaskMin10;
			half4 _Coords10;
			half4 _MaskMax9;
			half4 _MaskMin9;
			half4 _Coords9;
			half4 _MaskMin16;
			half4 _TerrainColor;
			half4 _MaskMax15;
			half4 _Coords16;
			half4 _Params5;
			half4 _Params2;
			half4 _Params3;
			half4 _Params4;
			half4 _Params6;
			half4 _Params7;
			half4 _Params8;
			half4 _Params1;
			half4 _Params9;
			half4 _Params11;
			half4 _Params12;
			half4 _Params13;
			half4 _Params14;
			half4 _Params15;
			half4 _Params16;
			half4 _Params10;
			half4 _Specular16;
			half4 _EmissiveColor;
			half4 _Specular7;
			half4 _Specular3;
			half4 _Specular4;
			half4 _Specular5;
			half4 _Specular6;
			half4 _Specular15;
			half4 _Specular8;
			half4 _Specular2;
			half4 _Specular9;
			half4 _Specular11;
			half4 _Specular12;
			half4 _Specular13;
			half4 _Specular14;
			half4 _Specular10;
			half4 _Specular1;
			half _EmissivePhaseValue;
			half _GlobalEmissive;
			half _TerrainSmoothnessValue;
			float _emissive_intensity_value;
			half _EmissiveAlbedoMode;
			half _TerrainOcclusionValue;
			half _EmissiveExposureValue;
			half _GlobalColors;
			half _OverlayProjectionValue;
			half _TerrainNormalValue;
			half _ColorsIntensityValue;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _TerrainHeightBlendValue;
			half _GlobalWetness;
			half _LayerColorsValue;
			half _CategoryGlobals;
			half _GlobalHeight;
			half _CategoryEmissive;
			half _CategoryMotion;
			half _EmissiveIntensityValue;
			half _EmissiveIntensityMode;
			half _EmissiveFlagMode;
			half _IsVersion;
			half _IsTerrainShader;
			half _CategoryRender;
			half _MessageTerrainEmissive;
			half _MessageTerrainColors;
			half _CategoryTerrain;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _IsCustomShader;
			half _IsShared;
			half _IsCollected;
			half _IsIdentifier;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceGlobalOptions;
			half _SpaceGlobalLocals;
			half _SpaceGlobalLayers;
			half _CategoryLayers;
			half _GlobalAlpha;
			half _TerrainLayersMode;
			half _TerrainBlendMode;
			half _LayerVertexValue;
			half _RenderClip;
			half _LayerSampleMode16;
			half _LayerSampleMode15;
			half _LayerSampleMode14;
			half _LayerSampleMode13;
			half _LayerSampleMode12;
			half _LayerSampleMode11;
			half _LayerSampleMode10;
			half _LayerSampleMode9;
			half _LayerSampleMode8;
			half _LayerSampleMode7;
			half _LayerSampleMode6;
			half _LayerSampleMode5;
			half _LayerSampleMode1;
			half _LayerSampleMode4;
			half _LayerSampleMode3;
			half _LayerSampleMode2;
			half _CategoryInputs;
			half _TerrainTexMode;
			half _RenderMode;
			half _RenderDecals;
			half _EmissiveMode;
			half _MessageTerrainMasks;
			half _AlphaClipValue;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(sampler_Linear_Clamp);
			half4 TVE_VertexParams;
			TEXTURE2D(_ControlTex1);
			SAMPLER(sampler_Linear_Clamp_Aniso8);
			TEXTURE2D(_ControlTex2);
			TEXTURE2D(_ControlTex3);
			TEXTURE2D(_ControlTex4);
			TEXTURE2D(_MaskTex1);
			SAMPLER(sampler_Linear_Repeat_Aniso8);
			TEXTURE2D(_MaskTex2);
			TEXTURE2D(_MaskTex3);
			TEXTURE2D(_MaskTex4);
			TEXTURE2D(_MaskTex5);
			TEXTURE2D(_MaskTex6);
			TEXTURE2D(_MaskTex7);
			TEXTURE2D(_MaskTex8);
			TEXTURE2D(_MaskTex9);
			TEXTURE2D(_MaskTex10);
			TEXTURE2D(_MaskTex11);
			TEXTURE2D(_MaskTex12);
			TEXTURE2D(_MaskTex13);
			TEXTURE2D(_MaskTex14);
			TEXTURE2D(_MaskTex15);
			TEXTURE2D(_MaskTex16);
			TEXTURE2D(_AlbedoTex1);
			TEXTURE2D(_AlbedoTex2);
			TEXTURE2D(_AlbedoTex3);
			TEXTURE2D(_AlbedoTex4);
			TEXTURE2D(_AlbedoTex5);
			TEXTURE2D(_AlbedoTex6);
			TEXTURE2D(_AlbedoTex7);
			TEXTURE2D(_AlbedoTex8);
			TEXTURE2D(_AlbedoTex9);
			TEXTURE2D(_AlbedoTex10);
			TEXTURE2D(_AlbedoTex11);
			TEXTURE2D(_AlbedoTex12);
			TEXTURE2D(_AlbedoTex13);
			TEXTURE2D(_AlbedoTex14);
			TEXTURE2D(_AlbedoTex15);
			TEXTURE2D(_AlbedoTex16);
			float TVE_ColorsUsage[10];
			TEXTURE2D_ARRAY(TVE_ColorsTex);
			half4 TVE_ColorsCoords;
			half4 TVE_ColorsParams;
			half TVE_IsEnabled;
			half4 TVE_OverlayColor;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			TEXTURE2D(_NormalTex1);
			TEXTURE2D(_NormalTex2);
			TEXTURE2D(_NormalTex3);
			TEXTURE2D(_NormalTex4);
			TEXTURE2D(_NormalTex5);
			TEXTURE2D(_NormalTex6);
			TEXTURE2D(_NormalTex7);
			TEXTURE2D(_NormalTex8);
			TEXTURE2D(_NormalTex9);
			TEXTURE2D(_NormalTex10);
			TEXTURE2D(_NormalTex11);
			TEXTURE2D(_NormalTex12);
			TEXTURE2D(_NormalTex13);
			TEXTURE2D(_NormalTex14);
			TEXTURE2D(_NormalTex15);
			TEXTURE2D(_NormalTex16);
			half TVE_WetnessContrast;
			half TVE_OverlayNormalValue;
			half TVE_WetnessNormalValue;
			half TVE_OverlaySmoothness;
			TEXTURE2D(_HolesTex);
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
        	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_VERT_TANGENT
			#pragma shader_feature_local_fragment TVE_ALPHA_CLIP
			#pragma shader_feature_local_fragment TVE_TERRAIN_04 TVE_TERRAIN_08 TVE_TERRAIN_12 TVE_TERRAIN_16
			#pragma shader_feature_local_fragment TVE_HEIGHT_BLEND
			#pragma shader_feature_local_fragment TVE_SAMPLE_01_PLANAR_2D TVE_SAMPLE_01_PLANAR_3D TVE_SAMPLE_01_STOCHASTIC_2D TVE_SAMPLE_01_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_02_PLANAR_2D TVE_SAMPLE_02_PLANAR_3D TVE_SAMPLE_02_STOCHASTIC_2D TVE_SAMPLE_02_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_03_PLANAR_2D TVE_SAMPLE_03_PLANAR_3D TVE_SAMPLE_03_STOCHASTIC_2D TVE_SAMPLE_03_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_04_PLANAR_2D TVE_SAMPLE_04_PLANAR_3D TVE_SAMPLE_04_STOCHASTIC_2D TVE_SAMPLE_04_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_05_PLANAR_2D TVE_SAMPLE_05_PLANAR_3D TVE_SAMPLE_05_STOCHASTIC_2D TVE_SAMPLE_05_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_06_PLANAR_2D TVE_SAMPLE_06_PLANAR_3D TVE_SAMPLE_06_STOCHASTIC_2D TVE_SAMPLE_06_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_07_PLANAR_2D TVE_SAMPLE_07_PLANAR_3D TVE_SAMPLE_07_STOCHASTIC_2D TVE_SAMPLE_07_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_08_PLANAR_2D TVE_SAMPLE_08_PLANAR_3D TVE_SAMPLE_08_STOCHASTIC_2D TVE_SAMPLE_08_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_09_PLANAR_2D TVE_SAMPLE_09_PLANAR_3D TVE_SAMPLE_09_STOCHASTIC_2D TVE_SAMPLE_09_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_10_PLANAR_2D TVE_SAMPLE_10_PLANAR_3D TVE_SAMPLE_10_STOCHASTIC_2D TVE_SAMPLE_10_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_11_PLANAR_2D TVE_SAMPLE_11_PLANAR_3D TVE_SAMPLE_11_STOCHASTIC_2D TVE_SAMPLE_11_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_12_PLANAR_2D TVE_SAMPLE_12_PLANAR_3D TVE_SAMPLE_12_STOCHASTIC_2D TVE_SAMPLE_12_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_13_PLANAR_2D TVE_SAMPLE_13_PLANAR_3D TVE_SAMPLE_13_STOCHASTIC_2D TVE_SAMPLE_13_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_14_PLANAR_2D TVE_SAMPLE_14_PLANAR_3D TVE_SAMPLE_14_STOCHASTIC_2D TVE_SAMPLE_14_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_15_PLANAR_2D TVE_SAMPLE_15_PLANAR_3D TVE_SAMPLE_15_STOCHASTIC_2D TVE_SAMPLE_15_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_SAMPLE_16_PLANAR_2D TVE_SAMPLE_16_PLANAR_3D TVE_SAMPLE_16_STOCHASTIC_2D TVE_SAMPLE_16_STOCHASTIC_3D
			#pragma shader_feature_local_fragment TVE_PACKED_TEX
			#pragma shader_feature_local_fragment TVE_EMISSIVE
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap forwardadd
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float3 previousPositionOS : TEXCOORD4;
				float3 precomputedVelocity : TEXCOORD5;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 uv1 : TEXCOORD3;
				float4 uv2 : TEXCOORD4;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 vpassPositionCS : TEXCOORD5;
					float3 vpassPreviousPositionCS : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			void ComputeWorldCoords( half4 Coords, half3 WorldPosition, out half2 ZX, out half2 ZY, out half2 XY )
			{
				ZX = WorldPosition.xz * Coords.xy + Coords.zw;
				ZY = WorldPosition.zy * Coords.xy + Coords.zw; 
				XY = WorldPosition.xy * Coords.xy + Coords.zw;
			}
			
			half4 SamplePlanar2D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half4 tex = SAMPLE_TEXTURE2D( Texture, Sampler, ZX);
				return tex;
			}
			
			void ComputeTriplanarWeights( half3 WorldNormal, out half T1, out half T2, out half T3 )
			{
				half3 powNormal = abs( WorldNormal.xyz );
				half3 weights = max( powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal * powNormal, 0.000001 );
				weights /= ( weights.x + weights.y + weights.z ).xxx;
				T1 = weights.y;
				T2 = weights.x;
				T3 = weights.z;
			}
			
			half4 SamplePlanar3D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition, half3 WorldNormal )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half T1, T2, T3;
				ComputeTriplanarWeights(WorldNormal, T1, T2, T3);
				half4 tex1 = SAMPLE_TEXTURE2D( Texture, Sampler, ZX);
				half4 tex2 = SAMPLE_TEXTURE2D( Texture, Sampler, ZY);
				half4 tex3 = SAMPLE_TEXTURE2D( Texture, Sampler, XY);
				return tex1 * T1 + tex2 * T2 + tex3 * T3;
			}
			
			void ComputeStochasticCoords( float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float W1, out float W2, out float W3 )
			{
				half2 vertex1, vertex2, vertex3;
				// Scaling of the input
				half2 uv = UV * 3.464; // 2 * sqrt (3)
				// Skew input space into simplex triangle grid
				const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
				half2 skewedCoord = mul( gridToSkewedGrid, uv );
				// Compute local triangle vertex IDs and local barycentric coordinates
				int2 baseId = int2( floor( skewedCoord ) );
				half3 temp = half3( frac( skewedCoord ), 0 );
				temp.z = 1.0 - temp.x - temp.y;
				if ( temp.z > 0.0 )
				{
					W1 = temp.z;
					W2 = temp.y;
					W3 = temp.x;
					vertex1 = baseId;
					vertex2 = baseId + int2( 0, 1 );
					vertex3 = baseId + int2( 1, 0 );
				}
				else
				{
					W1 = -temp.z;
					W2 = 1.0 - temp.y;
					W3 = 1.0 - temp.x;
					vertex1 = baseId + int2( 1, 1 );
					vertex2 = baseId + int2( 1, 0 );
					vertex3 = baseId + int2( 0, 1 );
				}
				UV1 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex1 ) ) * 43758.5453 );
				UV2 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex2 ) ) * 43758.5453 );
				UV3 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex3 ) ) * 43758.5453 );
				return;
			}
			
			float4 SampleStochastic2D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half2 UV1, UV2, UV3;
				half W1, W2, W3;
				ComputeStochasticCoords(ZX, UV1, UV2, UV3, W1, W2, W3 );
				half4 tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZX), ddy(ZX));
				half4 tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZX), ddy(ZX));
				half4 tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZX), ddy(ZX));
				return tex1 * W1 + tex2 * W2 + tex3 * W3;
			}
			
			half4 SampleStochastic3D( TEXTURE2D(Texture), SamplerState Sampler, half4 Coords, half3 WorldPosition, half3 WorldNormal )
			{
				half2 ZX, ZY, XY;
				ComputeWorldCoords(Coords, WorldPosition, ZX, ZY, XY);
				half2 UV1, UV2, UV3;
				half W1, W2, W3;
				half4 tex1, tex2, tex3;
				ComputeStochasticCoords(ZX, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZX), ddy(ZX));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZX), ddy(ZX));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZX), ddy(ZX));
				half4 texZX = tex1 * W1 + tex2 * W2 + tex3 * W3;
				ComputeStochasticCoords(ZY, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(ZY), ddy(ZY));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(ZY), ddy(ZY));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(ZY), ddy(ZY));
				half4 texZY = tex1 * W1 + tex2 * W2 + tex3 * W3;
				ComputeStochasticCoords(XY, UV1, UV2, UV3, W1, W2, W3 );
				tex1 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV1, ddx(XY), ddy(XY));
				tex2 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV2, ddx(XY), ddy(XY));
				tex3 = SAMPLE_TEXTURE2D_GRAD( Texture, Sampler, UV3, ddx(XY), ddy(XY));
				half4 texXY = tex1 * W1 + tex2 * W2 + tex3 * W3;
				half T1, T2, T3;
				ComputeTriplanarWeights(WorldNormal, T1, T2, T3);
				return texZX * T1 + texZY * T2 + texXY * T3;
			}
			
			float3 ASEGetEmissionHDRColor(float3 ldrColor, float luminanceIntensity, float exposureWeight, float inverseCurrentExposureMultiplier)
			{
				float3 hdrColor = ldrColor * luminanceIntensity;
				hdrColor = lerp( hdrColor* inverseCurrentExposureMultiplier, hdrColor, exposureWeight);
				return hdrColor;
			}
			
			AttributesMesh ApplyMeshModification( AttributesMesh inputMesh )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = inputMesh.positionOS.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				inputMesh.positionOS.xz = sampleCoords* _TerrainHeightmapScale.xz;
				inputMesh.positionOS.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					inputMesh.normalOS = float3(0, 1, 0);
				#else
					inputMesh.normalOS = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				inputMesh.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return inputMesh;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
				surfaceData.specularOcclusion = 1.0;

				surfaceData.baseColor =                 surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness = 				surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
                    float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;

	            

	            
                #if ASE_SRP_VERSION >=140008
                #ifdef DECAL_NORMAL_BLENDING
					normalTS = SurfaceGradientFromTangentSpaceNormalAndFromTBN(normalTS, fragInputs.tangentToWorld[0], fragInputs.tangentToWorld[1]);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;

                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, fragInputs.tangentToWorld[2], normalTS);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                     }
                    #endif

                    GetNormalWS_SG(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);
                #else
					GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

                    #if HAVE_DECALS
                    if (_EnableDecals)
                    {
                        float alpha = 1.0;
                        alpha = surfaceDescription.Alpha;
        
                        DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, alpha);
                        ApplyDecalToSurfaceNormal(decalSurfaceData, surfaceData.normalWS.xyz);
                        ApplyDecalToSurfaceDataNoNormal(decalSurfaceData, surfaceData);
                    }
                    #endif
                #endif
                #endif
               

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
				    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				    {
					   surfaceData.metallic = 0;
				    }
				    ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData); 
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif  
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				inputMesh = ApplyMeshModification(inputMesh);
				float3 VertexPosition3588_g79798 = inputMesh.positionOS;
				float temp_output_84_0_g79811 = _LayerVertexValue;
				float temp_output_19_0_g79815 = TVE_VertexUsage[(int)temp_output_84_0_g79811];
				float4 temp_output_94_19_g79811 = TVE_VertexCoords;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag7344_g79798 = ase_worldPos;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV97_g79811 = ( (temp_output_94_19_g79811).zw + ( (temp_output_94_19_g79811).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode50_g79811 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g79811,temp_output_84_0_g79811, 0.0 );
				float4 temp_output_17_0_g79815 = tex2DArrayNode50_g79811;
				float4 temp_output_111_19_g79811 = TVE_VertexParams;
				float4 temp_output_3_0_g79815 = temp_output_111_19_g79811;
				float4 ifLocalVar18_g79815 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79815 >= 0.5 )
				ifLocalVar18_g79815 = temp_output_17_0_g79815;
				else
				ifLocalVar18_g79815 = temp_output_3_0_g79815;
				float4 lerpResult22_g79815 = lerp( temp_output_3_0_g79815 , temp_output_17_0_g79815 , temp_output_19_0_g79815);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79815 = lerpResult22_g79815;
				#else
				float4 staticSwitch24_g79815 = ifLocalVar18_g79815;
				#endif
				half4 Global_Vertex_Params4173_g79798 = staticSwitch24_g79815;
				float4 break322_g79802 = Global_Vertex_Params4173_g79798;
				half Global_VertexOffset7327_g79798 = break322_g79802.z;
				float3 appendResult7336_g79798 = (float3(0.0 , ( Global_VertexOffset7327_g79798 * _GlobalHeight ) , 0.0));
				half3 Vertex_Offset7335_g79798 = appendResult7336_g79798;
				float3 Vertex_Output890_g79798 = ( VertexPosition3588_g79798 + Vertex_Offset7335_g79798 );
				
				float4 appendResult7007_g79798 = (float4(cross( inputMesh.normalOS , float3(0,0,1) ) , -1.0));
				half4 Vertex_Tangents7390_g79798 = appendResult7007_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord8.xyz = vertexToFrag7344_g79798;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 ase_worldTangent = TransformObjectToWorldDir(inputMesh.tangentOS.xyz);
				float ase_vertexTangentSign = inputMesh.tangentOS.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				outputPackedVaryingsMeshToPS.ase_texcoord9.xyz = ase_worldBitangent;
				
				outputPackedVaryingsMeshToPS.ase_texcoord7.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord7.zw = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord8.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord9.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Vertex_Output890_g79798;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = Vertex_Tangents7390_g79798;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(positionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}
				#endif

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.uv1.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.uv2.xyzw = inputMesh.uv2;

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outputPackedVaryingsMeshToPS.vpassPositionCS = float3(VPASSpositionCS.xyw);
					outputPackedVaryingsMeshToPS.vpassPreviousPositionCS = float3(VPASSpreviousPositionCS.xyw);
				#endif
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplayMaterial.hlsl"

            #ifdef UNITY_VIRTUAL_TEXTURING
                #ifdef OUTPUT_SPLIT_LIGHTING
                   #define DIFFUSE_LIGHTING_TARGET SV_Target2
                   #define SSS_BUFFER_TARGET SV_Target3
                #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
                   #define MOTION_VECTOR_TARGET SV_Target2
            	#endif
            #if defined(SHADER_API_PSSL)
            	#pragma PSSL_target_output_format(target 1 FMT_32_ABGR)
            #endif
            #else
                #ifdef OUTPUT_SPLIT_LIGHTING
                #define DIFFUSE_LIGHTING_TARGET SV_Target1
                #define SSS_BUFFER_TARGET SV_Target2
                #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
                #define MOTION_VECTOR_TARGET SV_Target1
                #endif
            #endif

			void Frag(PackedVaryingsMeshToPS packedInput
				, out float4 outColor:SV_Target0
            #ifdef UNITY_VIRTUAL_TEXTURING
				, out float4 outVTFeedback : SV_Target1
            #endif
            #ifdef OUTPUT_SPLIT_LIGHTING
				, out float4 outDiffuseLighting : DIFFUSE_LIGHTING_TARGET
				, OUTPUT_SSSBUFFER(outSSSBuffer) : SSS_BUFFER_TARGET
            #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
				, out float4 outMotionVec : MOTION_VECTOR_TARGET
            #endif
            #ifdef _DEPTHOFFSET_ON
				, out float outputDepth : DEPTH_OFFSET_SEMANTIC
            #endif
		    
						)
			{
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outMotionVec = float4(2.0, 0.0, 0.0, 1.0);
				#endif

				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.uv1.xyzw;
				input.texCoord2 = packedInput.uv2.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				

				
				AdjustFragInputsToOffScreenRendering(input, _OffScreenRendering > 0, _OffScreenDownsampleFactor);
			

				uint2 tileIndex = uint2(input.positionSS.xy) / GetTileSize ();

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz, tileIndex );

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float localHeightBasedBlending7362_g83242 = ( 0.0 );
				float2 Terrain_Control_UV7873_g83242 = packedInput.ase_texcoord7.xy;
				half4 Terrain_Control_047365_g83242 = SAMPLE_TEXTURE2D( _ControlTex1, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_047362_g83242 = Terrain_Control_047365_g83242;
				half4 Terrain_Control_087366_g83242 = SAMPLE_TEXTURE2D( _ControlTex2, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_087362_g83242 = Terrain_Control_087366_g83242;
				half4 Terrain_Control_127712_g83242 = SAMPLE_TEXTURE2D( _ControlTex3, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_127362_g83242 = Terrain_Control_127712_g83242;
				half4 Terrain_Control_167711_g83242 = SAMPLE_TEXTURE2D( _ControlTex4, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 );
				float4 control_167362_g83242 = Terrain_Control_167711_g83242;
				TEXTURE2D(Texture238_g83299) = _MaskTex1;
				SamplerState Sampler238_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_016785_g83242 = _Coords1;
				float4 temp_output_37_0_g83299 = Input_Coords_016785_g83242;
				half4 Coords238_g83299 = temp_output_37_0_g83299;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				half3 WorldPosition238_g83299 = ase_worldPos;
				half4 localSamplePlanar2D238_g83299 = SamplePlanar2D( Texture238_g83299 , Sampler238_g83299 , Coords238_g83299 , WorldPosition238_g83299 );
				TEXTURE2D(Texture246_g83299) = _MaskTex1;
				SamplerState Sampler246_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83299 = temp_output_37_0_g83299;
				half3 WorldPosition246_g83299 = ase_worldPos;
				half3 WorldNormal246_g83299 = normalWS;
				half4 localSamplePlanar3D246_g83299 = SamplePlanar3D( Texture246_g83299 , Sampler246_g83299 , Coords246_g83299 , WorldPosition246_g83299 , WorldNormal246_g83299 );
				TEXTURE2D(Texture234_g83299) = _MaskTex1;
				SamplerState Sampler234_g83299 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83299 = temp_output_37_0_g83299;
				float3 WorldPosition234_g83299 = ase_worldPos;
				float4 localSampleStochastic2D234_g83299 = SampleStochastic2D( Texture234_g83299 , Sampler234_g83299 , Coords234_g83299 , WorldPosition234_g83299 );
				TEXTURE2D(Texture263_g83299) = _MaskTex1;
				SamplerState Sampler263_g83299 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83299 = temp_output_37_0_g83299;
				half3 WorldPosition263_g83299 = ase_worldPos;
				half3 WorldNormal263_g83299 = normalWS;
				half4 localSampleStochastic3D263_g83299 = SampleStochastic3D( Texture263_g83299 , Sampler263_g83299 , Coords263_g83299 , WorldPosition263_g83299 , WorldNormal263_g83299 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8639_g83242 = localSamplePlanar2D238_g83299;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8639_g83242 = localSamplePlanar3D246_g83299;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8639_g83242 = localSampleStochastic2D234_g83299;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8639_g83242 = localSampleStochastic3D263_g83299;
				#else
				float4 staticSwitch8639_g83242 = localSamplePlanar2D238_g83299;
				#endif
				float4 temp_output_7_0_g83248 = _MaskMin1;
				float4 temp_output_10_0_g83248 = ( _MaskMax1 - temp_output_7_0_g83248 );
				float4 temp_output_6970_0_g83242 = saturate( ( ( staticSwitch8639_g83242 - temp_output_7_0_g83248 ) / ( temp_output_10_0_g83248 + 0.0001 ) ) );
				half4 Masks_015_g83256 = temp_output_6970_0_g83242;
				TEXTURE2D(Texture238_g83300) = _MaskTex2;
				SamplerState Sampler238_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_026787_g83242 = _Coords2;
				float4 temp_output_37_0_g83300 = Input_Coords_026787_g83242;
				half4 Coords238_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition238_g83300 = ase_worldPos;
				half4 localSamplePlanar2D238_g83300 = SamplePlanar2D( Texture238_g83300 , Sampler238_g83300 , Coords238_g83300 , WorldPosition238_g83300 );
				TEXTURE2D(Texture246_g83300) = _MaskTex2;
				SamplerState Sampler246_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition246_g83300 = ase_worldPos;
				half3 WorldNormal246_g83300 = normalWS;
				half4 localSamplePlanar3D246_g83300 = SamplePlanar3D( Texture246_g83300 , Sampler246_g83300 , Coords246_g83300 , WorldPosition246_g83300 , WorldNormal246_g83300 );
				TEXTURE2D(Texture234_g83300) = _MaskTex2;
				SamplerState Sampler234_g83300 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83300 = temp_output_37_0_g83300;
				float3 WorldPosition234_g83300 = ase_worldPos;
				float4 localSampleStochastic2D234_g83300 = SampleStochastic2D( Texture234_g83300 , Sampler234_g83300 , Coords234_g83300 , WorldPosition234_g83300 );
				TEXTURE2D(Texture263_g83300) = _MaskTex2;
				SamplerState Sampler263_g83300 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83300 = temp_output_37_0_g83300;
				half3 WorldPosition263_g83300 = ase_worldPos;
				half3 WorldNormal263_g83300 = normalWS;
				half4 localSampleStochastic3D263_g83300 = SampleStochastic3D( Texture263_g83300 , Sampler263_g83300 , Coords263_g83300 , WorldPosition263_g83300 , WorldNormal263_g83300 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8640_g83242 = localSamplePlanar2D238_g83300;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8640_g83242 = localSamplePlanar3D246_g83300;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8640_g83242 = localSampleStochastic2D234_g83300;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8640_g83242 = localSampleStochastic3D263_g83300;
				#else
				float4 staticSwitch8640_g83242 = localSamplePlanar2D238_g83300;
				#endif
				float4 temp_output_7_0_g83250 = _MaskMin2;
				float4 temp_output_10_0_g83250 = ( _MaskMax2 - temp_output_7_0_g83250 );
				float4 temp_output_6977_0_g83242 = saturate( ( ( staticSwitch8640_g83242 - temp_output_7_0_g83250 ) / ( temp_output_10_0_g83250 + 0.0001 ) ) );
				half4 Masks_0210_g83256 = temp_output_6977_0_g83242;
				TEXTURE2D(Texture238_g83301) = _MaskTex3;
				SamplerState Sampler238_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_036789_g83242 = _Coords3;
				float4 temp_output_37_0_g83301 = Input_Coords_036789_g83242;
				half4 Coords238_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition238_g83301 = ase_worldPos;
				half4 localSamplePlanar2D238_g83301 = SamplePlanar2D( Texture238_g83301 , Sampler238_g83301 , Coords238_g83301 , WorldPosition238_g83301 );
				TEXTURE2D(Texture246_g83301) = _MaskTex3;
				SamplerState Sampler246_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition246_g83301 = ase_worldPos;
				half3 WorldNormal246_g83301 = normalWS;
				half4 localSamplePlanar3D246_g83301 = SamplePlanar3D( Texture246_g83301 , Sampler246_g83301 , Coords246_g83301 , WorldPosition246_g83301 , WorldNormal246_g83301 );
				TEXTURE2D(Texture234_g83301) = _MaskTex3;
				SamplerState Sampler234_g83301 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83301 = temp_output_37_0_g83301;
				float3 WorldPosition234_g83301 = ase_worldPos;
				float4 localSampleStochastic2D234_g83301 = SampleStochastic2D( Texture234_g83301 , Sampler234_g83301 , Coords234_g83301 , WorldPosition234_g83301 );
				TEXTURE2D(Texture263_g83301) = _MaskTex3;
				SamplerState Sampler263_g83301 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83301 = temp_output_37_0_g83301;
				half3 WorldPosition263_g83301 = ase_worldPos;
				half3 WorldNormal263_g83301 = normalWS;
				half4 localSampleStochastic3D263_g83301 = SampleStochastic3D( Texture263_g83301 , Sampler263_g83301 , Coords263_g83301 , WorldPosition263_g83301 , WorldNormal263_g83301 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8641_g83242 = localSamplePlanar2D238_g83301;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8641_g83242 = localSamplePlanar3D246_g83301;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8641_g83242 = localSampleStochastic2D234_g83301;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8641_g83242 = localSampleStochastic3D263_g83301;
				#else
				float4 staticSwitch8641_g83242 = localSamplePlanar2D238_g83301;
				#endif
				float4 temp_output_7_0_g83251 = _MaskMin3;
				float4 temp_output_10_0_g83251 = ( _MaskMax3 - temp_output_7_0_g83251 );
				float4 temp_output_6978_0_g83242 = saturate( ( ( staticSwitch8641_g83242 - temp_output_7_0_g83251 ) / ( temp_output_10_0_g83251 + 0.0001 ) ) );
				half4 Masks_0312_g83256 = temp_output_6978_0_g83242;
				TEXTURE2D(Texture238_g83302) = _MaskTex4;
				SamplerState Sampler238_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_046791_g83242 = _Coords4;
				float4 temp_output_37_0_g83302 = Input_Coords_046791_g83242;
				half4 Coords238_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition238_g83302 = ase_worldPos;
				half4 localSamplePlanar2D238_g83302 = SamplePlanar2D( Texture238_g83302 , Sampler238_g83302 , Coords238_g83302 , WorldPosition238_g83302 );
				TEXTURE2D(Texture246_g83302) = _MaskTex4;
				SamplerState Sampler246_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition246_g83302 = ase_worldPos;
				half3 WorldNormal246_g83302 = normalWS;
				half4 localSamplePlanar3D246_g83302 = SamplePlanar3D( Texture246_g83302 , Sampler246_g83302 , Coords246_g83302 , WorldPosition246_g83302 , WorldNormal246_g83302 );
				TEXTURE2D(Texture234_g83302) = _MaskTex4;
				SamplerState Sampler234_g83302 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83302 = temp_output_37_0_g83302;
				float3 WorldPosition234_g83302 = ase_worldPos;
				float4 localSampleStochastic2D234_g83302 = SampleStochastic2D( Texture234_g83302 , Sampler234_g83302 , Coords234_g83302 , WorldPosition234_g83302 );
				TEXTURE2D(Texture263_g83302) = _MaskTex4;
				SamplerState Sampler263_g83302 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83302 = temp_output_37_0_g83302;
				half3 WorldPosition263_g83302 = ase_worldPos;
				half3 WorldNormal263_g83302 = normalWS;
				half4 localSampleStochastic3D263_g83302 = SampleStochastic3D( Texture263_g83302 , Sampler263_g83302 , Coords263_g83302 , WorldPosition263_g83302 , WorldNormal263_g83302 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8642_g83242 = localSamplePlanar2D238_g83302;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8642_g83242 = localSamplePlanar3D246_g83302;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8642_g83242 = localSampleStochastic2D234_g83302;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8642_g83242 = localSampleStochastic3D263_g83302;
				#else
				float4 staticSwitch8642_g83242 = localSamplePlanar2D238_g83302;
				#endif
				float4 temp_output_7_0_g83252 = _MaskMin4;
				float4 temp_output_10_0_g83252 = ( _MaskMax4 - temp_output_7_0_g83252 );
				float4 temp_output_6983_0_g83242 = saturate( ( ( staticSwitch8642_g83242 - temp_output_7_0_g83252 ) / ( temp_output_10_0_g83252 + 0.0001 ) ) );
				half4 Masks_0414_g83256 = temp_output_6983_0_g83242;
				float4 appendResult29_g83256 = (float4((Masks_015_g83256).z , (Masks_0210_g83256).z , (Masks_0312_g83256).z , (Masks_0414_g83256).z));
				half4 Control31_g83256 = Terrain_Control_047365_g83242;
				half4 Terrain_Height_047210_g83242 = ( appendResult29_g83256 * Control31_g83256 );
				float4 heights_047362_g83242 = Terrain_Height_047210_g83242;
				TEXTURE2D(Texture238_g83311) = _MaskTex5;
				SamplerState Sampler238_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_058750_g83242 = _Coords5;
				float4 temp_output_37_0_g83311 = Input_Coords_058750_g83242;
				half4 Coords238_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition238_g83311 = ase_worldPos;
				half4 localSamplePlanar2D238_g83311 = SamplePlanar2D( Texture238_g83311 , Sampler238_g83311 , Coords238_g83311 , WorldPosition238_g83311 );
				TEXTURE2D(Texture246_g83311) = _MaskTex5;
				SamplerState Sampler246_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition246_g83311 = ase_worldPos;
				half3 WorldNormal246_g83311 = normalWS;
				half4 localSamplePlanar3D246_g83311 = SamplePlanar3D( Texture246_g83311 , Sampler246_g83311 , Coords246_g83311 , WorldPosition246_g83311 , WorldNormal246_g83311 );
				TEXTURE2D(Texture234_g83311) = _MaskTex5;
				SamplerState Sampler234_g83311 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83311 = temp_output_37_0_g83311;
				float3 WorldPosition234_g83311 = ase_worldPos;
				float4 localSampleStochastic2D234_g83311 = SampleStochastic2D( Texture234_g83311 , Sampler234_g83311 , Coords234_g83311 , WorldPosition234_g83311 );
				TEXTURE2D(Texture263_g83311) = _MaskTex5;
				SamplerState Sampler263_g83311 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83311 = temp_output_37_0_g83311;
				half3 WorldPosition263_g83311 = ase_worldPos;
				half3 WorldNormal263_g83311 = normalWS;
				half4 localSampleStochastic3D263_g83311 = SampleStochastic3D( Texture263_g83311 , Sampler263_g83311 , Coords263_g83311 , WorldPosition263_g83311 , WorldNormal263_g83311 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8710_g83242 = localSamplePlanar2D238_g83311;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8710_g83242 = localSamplePlanar3D246_g83311;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8710_g83242 = localSampleStochastic2D234_g83311;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8710_g83242 = localSampleStochastic3D263_g83311;
				#else
				float4 staticSwitch8710_g83242 = localSamplePlanar2D238_g83311;
				#endif
				float4 temp_output_7_0_g83264 = _MaskMin5;
				float4 temp_output_10_0_g83264 = ( _MaskMax5 - temp_output_7_0_g83264 );
				float4 temp_output_8714_0_g83242 = saturate( ( ( staticSwitch8710_g83242 - temp_output_7_0_g83264 ) / ( temp_output_10_0_g83264 + 0.0001 ) ) );
				half4 Masks_015_g83265 = temp_output_8714_0_g83242;
				TEXTURE2D(Texture238_g83312) = _MaskTex6;
				SamplerState Sampler238_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_068751_g83242 = _Coords6;
				float4 temp_output_37_0_g83312 = Input_Coords_068751_g83242;
				half4 Coords238_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition238_g83312 = ase_worldPos;
				half4 localSamplePlanar2D238_g83312 = SamplePlanar2D( Texture238_g83312 , Sampler238_g83312 , Coords238_g83312 , WorldPosition238_g83312 );
				TEXTURE2D(Texture246_g83312) = _MaskTex6;
				SamplerState Sampler246_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition246_g83312 = ase_worldPos;
				half3 WorldNormal246_g83312 = normalWS;
				half4 localSamplePlanar3D246_g83312 = SamplePlanar3D( Texture246_g83312 , Sampler246_g83312 , Coords246_g83312 , WorldPosition246_g83312 , WorldNormal246_g83312 );
				TEXTURE2D(Texture234_g83312) = _MaskTex6;
				SamplerState Sampler234_g83312 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83312 = temp_output_37_0_g83312;
				float3 WorldPosition234_g83312 = ase_worldPos;
				float4 localSampleStochastic2D234_g83312 = SampleStochastic2D( Texture234_g83312 , Sampler234_g83312 , Coords234_g83312 , WorldPosition234_g83312 );
				TEXTURE2D(Texture263_g83312) = _MaskTex6;
				SamplerState Sampler263_g83312 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83312 = temp_output_37_0_g83312;
				half3 WorldPosition263_g83312 = ase_worldPos;
				half3 WorldNormal263_g83312 = normalWS;
				half4 localSampleStochastic3D263_g83312 = SampleStochastic3D( Texture263_g83312 , Sampler263_g83312 , Coords263_g83312 , WorldPosition263_g83312 , WorldNormal263_g83312 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8711_g83242 = localSamplePlanar2D238_g83312;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8711_g83242 = localSamplePlanar3D246_g83312;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8711_g83242 = localSampleStochastic2D234_g83312;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8711_g83242 = localSampleStochastic3D263_g83312;
				#else
				float4 staticSwitch8711_g83242 = localSamplePlanar2D238_g83312;
				#endif
				float4 temp_output_7_0_g83267 = _MaskMin6;
				float4 temp_output_10_0_g83267 = ( _MaskMax6 - temp_output_7_0_g83267 );
				float4 temp_output_8721_0_g83242 = saturate( ( ( staticSwitch8711_g83242 - temp_output_7_0_g83267 ) / ( temp_output_10_0_g83267 + 0.0001 ) ) );
				half4 Masks_0210_g83265 = temp_output_8721_0_g83242;
				TEXTURE2D(Texture238_g83313) = _MaskTex7;
				SamplerState Sampler238_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_078752_g83242 = _Coords7;
				float4 temp_output_37_0_g83313 = Input_Coords_078752_g83242;
				half4 Coords238_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition238_g83313 = ase_worldPos;
				half4 localSamplePlanar2D238_g83313 = SamplePlanar2D( Texture238_g83313 , Sampler238_g83313 , Coords238_g83313 , WorldPosition238_g83313 );
				TEXTURE2D(Texture246_g83313) = _MaskTex7;
				SamplerState Sampler246_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition246_g83313 = ase_worldPos;
				half3 WorldNormal246_g83313 = normalWS;
				half4 localSamplePlanar3D246_g83313 = SamplePlanar3D( Texture246_g83313 , Sampler246_g83313 , Coords246_g83313 , WorldPosition246_g83313 , WorldNormal246_g83313 );
				TEXTURE2D(Texture234_g83313) = _MaskTex7;
				SamplerState Sampler234_g83313 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83313 = temp_output_37_0_g83313;
				float3 WorldPosition234_g83313 = ase_worldPos;
				float4 localSampleStochastic2D234_g83313 = SampleStochastic2D( Texture234_g83313 , Sampler234_g83313 , Coords234_g83313 , WorldPosition234_g83313 );
				TEXTURE2D(Texture263_g83313) = _MaskTex7;
				SamplerState Sampler263_g83313 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83313 = temp_output_37_0_g83313;
				half3 WorldPosition263_g83313 = ase_worldPos;
				half3 WorldNormal263_g83313 = normalWS;
				half4 localSampleStochastic3D263_g83313 = SampleStochastic3D( Texture263_g83313 , Sampler263_g83313 , Coords263_g83313 , WorldPosition263_g83313 , WorldNormal263_g83313 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8712_g83242 = localSamplePlanar2D238_g83313;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8712_g83242 = localSamplePlanar3D246_g83313;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8712_g83242 = localSampleStochastic2D234_g83313;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8712_g83242 = localSampleStochastic3D263_g83313;
				#else
				float4 staticSwitch8712_g83242 = localSamplePlanar2D238_g83313;
				#endif
				float4 temp_output_7_0_g83268 = _MaskMin7;
				float4 temp_output_10_0_g83268 = ( _MaskMax7 - temp_output_7_0_g83268 );
				float4 temp_output_8724_0_g83242 = saturate( ( ( staticSwitch8712_g83242 - temp_output_7_0_g83268 ) / ( temp_output_10_0_g83268 + 0.0001 ) ) );
				half4 Masks_0312_g83265 = temp_output_8724_0_g83242;
				TEXTURE2D(Texture238_g83314) = _MaskTex8;
				SamplerState Sampler238_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_088749_g83242 = _Coords8;
				float4 temp_output_37_0_g83314 = Input_Coords_088749_g83242;
				half4 Coords238_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition238_g83314 = ase_worldPos;
				half4 localSamplePlanar2D238_g83314 = SamplePlanar2D( Texture238_g83314 , Sampler238_g83314 , Coords238_g83314 , WorldPosition238_g83314 );
				TEXTURE2D(Texture246_g83314) = _MaskTex8;
				SamplerState Sampler246_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition246_g83314 = ase_worldPos;
				half3 WorldNormal246_g83314 = normalWS;
				half4 localSamplePlanar3D246_g83314 = SamplePlanar3D( Texture246_g83314 , Sampler246_g83314 , Coords246_g83314 , WorldPosition246_g83314 , WorldNormal246_g83314 );
				TEXTURE2D(Texture234_g83314) = _MaskTex8;
				SamplerState Sampler234_g83314 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83314 = temp_output_37_0_g83314;
				float3 WorldPosition234_g83314 = ase_worldPos;
				float4 localSampleStochastic2D234_g83314 = SampleStochastic2D( Texture234_g83314 , Sampler234_g83314 , Coords234_g83314 , WorldPosition234_g83314 );
				TEXTURE2D(Texture263_g83314) = _MaskTex8;
				SamplerState Sampler263_g83314 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83314 = temp_output_37_0_g83314;
				half3 WorldPosition263_g83314 = ase_worldPos;
				half3 WorldNormal263_g83314 = normalWS;
				half4 localSampleStochastic3D263_g83314 = SampleStochastic3D( Texture263_g83314 , Sampler263_g83314 , Coords263_g83314 , WorldPosition263_g83314 , WorldNormal263_g83314 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8713_g83242 = localSamplePlanar2D238_g83314;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8713_g83242 = localSamplePlanar3D246_g83314;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8713_g83242 = localSampleStochastic2D234_g83314;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8713_g83242 = localSampleStochastic3D263_g83314;
				#else
				float4 staticSwitch8713_g83242 = localSamplePlanar2D238_g83314;
				#endif
				float4 temp_output_7_0_g83269 = _MaskMin8;
				float4 temp_output_10_0_g83269 = ( _MaskMax8 - temp_output_7_0_g83269 );
				float4 temp_output_8727_0_g83242 = saturate( ( ( staticSwitch8713_g83242 - temp_output_7_0_g83269 ) / ( temp_output_10_0_g83269 + 0.0001 ) ) );
				half4 Masks_0414_g83265 = temp_output_8727_0_g83242;
				float4 appendResult29_g83265 = (float4((Masks_015_g83265).z , (Masks_0210_g83265).z , (Masks_0312_g83265).z , (Masks_0414_g83265).z));
				half4 Control31_g83265 = Terrain_Control_087366_g83242;
				half4 Terrain_Height_088731_g83242 = ( appendResult29_g83265 * Control31_g83265 );
				float4 heights_087362_g83242 = Terrain_Height_088731_g83242;
				TEXTURE2D(Texture238_g83323) = _MaskTex9;
				SamplerState Sampler238_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_098833_g83242 = _Coords9;
				float4 temp_output_37_0_g83323 = Input_Coords_098833_g83242;
				half4 Coords238_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition238_g83323 = ase_worldPos;
				half4 localSamplePlanar2D238_g83323 = SamplePlanar2D( Texture238_g83323 , Sampler238_g83323 , Coords238_g83323 , WorldPosition238_g83323 );
				TEXTURE2D(Texture246_g83323) = _MaskTex9;
				SamplerState Sampler246_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition246_g83323 = ase_worldPos;
				half3 WorldNormal246_g83323 = normalWS;
				half4 localSamplePlanar3D246_g83323 = SamplePlanar3D( Texture246_g83323 , Sampler246_g83323 , Coords246_g83323 , WorldPosition246_g83323 , WorldNormal246_g83323 );
				TEXTURE2D(Texture234_g83323) = _MaskTex9;
				SamplerState Sampler234_g83323 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83323 = temp_output_37_0_g83323;
				float3 WorldPosition234_g83323 = ase_worldPos;
				float4 localSampleStochastic2D234_g83323 = SampleStochastic2D( Texture234_g83323 , Sampler234_g83323 , Coords234_g83323 , WorldPosition234_g83323 );
				TEXTURE2D(Texture263_g83323) = _MaskTex9;
				SamplerState Sampler263_g83323 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83323 = temp_output_37_0_g83323;
				half3 WorldPosition263_g83323 = ase_worldPos;
				half3 WorldNormal263_g83323 = normalWS;
				half4 localSampleStochastic3D263_g83323 = SampleStochastic3D( Texture263_g83323 , Sampler263_g83323 , Coords263_g83323 , WorldPosition263_g83323 , WorldNormal263_g83323 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8878_g83242 = localSamplePlanar2D238_g83323;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8878_g83242 = localSamplePlanar3D246_g83323;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8878_g83242 = localSampleStochastic2D234_g83323;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8878_g83242 = localSampleStochastic3D263_g83323;
				#else
				float4 staticSwitch8878_g83242 = localSamplePlanar2D238_g83323;
				#endif
				float4 temp_output_7_0_g83274 = _MaskMin9;
				float4 temp_output_10_0_g83274 = ( _MaskMax9 - temp_output_7_0_g83274 );
				float4 temp_output_8815_0_g83242 = saturate( ( ( staticSwitch8878_g83242 - temp_output_7_0_g83274 ) / ( temp_output_10_0_g83274 + 0.0001 ) ) );
				half4 Masks_015_g83275 = temp_output_8815_0_g83242;
				TEXTURE2D(Texture238_g83324) = _MaskTex10;
				SamplerState Sampler238_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_108834_g83242 = _Coords10;
				float4 temp_output_37_0_g83324 = Input_Coords_108834_g83242;
				half4 Coords238_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition238_g83324 = ase_worldPos;
				half4 localSamplePlanar2D238_g83324 = SamplePlanar2D( Texture238_g83324 , Sampler238_g83324 , Coords238_g83324 , WorldPosition238_g83324 );
				TEXTURE2D(Texture246_g83324) = _MaskTex10;
				SamplerState Sampler246_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition246_g83324 = ase_worldPos;
				half3 WorldNormal246_g83324 = normalWS;
				half4 localSamplePlanar3D246_g83324 = SamplePlanar3D( Texture246_g83324 , Sampler246_g83324 , Coords246_g83324 , WorldPosition246_g83324 , WorldNormal246_g83324 );
				TEXTURE2D(Texture234_g83324) = _MaskTex10;
				SamplerState Sampler234_g83324 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83324 = temp_output_37_0_g83324;
				float3 WorldPosition234_g83324 = ase_worldPos;
				float4 localSampleStochastic2D234_g83324 = SampleStochastic2D( Texture234_g83324 , Sampler234_g83324 , Coords234_g83324 , WorldPosition234_g83324 );
				TEXTURE2D(Texture263_g83324) = _MaskTex10;
				SamplerState Sampler263_g83324 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83324 = temp_output_37_0_g83324;
				half3 WorldPosition263_g83324 = ase_worldPos;
				half3 WorldNormal263_g83324 = normalWS;
				half4 localSampleStochastic3D263_g83324 = SampleStochastic3D( Texture263_g83324 , Sampler263_g83324 , Coords263_g83324 , WorldPosition263_g83324 , WorldNormal263_g83324 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8860_g83242 = localSamplePlanar2D238_g83324;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8860_g83242 = localSamplePlanar3D246_g83324;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8860_g83242 = localSampleStochastic2D234_g83324;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8860_g83242 = localSampleStochastic3D263_g83324;
				#else
				float4 staticSwitch8860_g83242 = localSamplePlanar2D238_g83324;
				#endif
				float4 temp_output_7_0_g83277 = _MaskMin10;
				float4 temp_output_10_0_g83277 = ( _MaskMax10 - temp_output_7_0_g83277 );
				float4 temp_output_8818_0_g83242 = saturate( ( ( staticSwitch8860_g83242 - temp_output_7_0_g83277 ) / ( temp_output_10_0_g83277 + 0.0001 ) ) );
				half4 Masks_0210_g83275 = temp_output_8818_0_g83242;
				TEXTURE2D(Texture238_g83325) = _MaskTex11;
				SamplerState Sampler238_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_118835_g83242 = _Coords11;
				float4 temp_output_37_0_g83325 = Input_Coords_118835_g83242;
				half4 Coords238_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition238_g83325 = ase_worldPos;
				half4 localSamplePlanar2D238_g83325 = SamplePlanar2D( Texture238_g83325 , Sampler238_g83325 , Coords238_g83325 , WorldPosition238_g83325 );
				TEXTURE2D(Texture246_g83325) = _MaskTex11;
				SamplerState Sampler246_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition246_g83325 = ase_worldPos;
				half3 WorldNormal246_g83325 = normalWS;
				half4 localSamplePlanar3D246_g83325 = SamplePlanar3D( Texture246_g83325 , Sampler246_g83325 , Coords246_g83325 , WorldPosition246_g83325 , WorldNormal246_g83325 );
				TEXTURE2D(Texture234_g83325) = _MaskTex11;
				SamplerState Sampler234_g83325 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83325 = temp_output_37_0_g83325;
				float3 WorldPosition234_g83325 = ase_worldPos;
				float4 localSampleStochastic2D234_g83325 = SampleStochastic2D( Texture234_g83325 , Sampler234_g83325 , Coords234_g83325 , WorldPosition234_g83325 );
				TEXTURE2D(Texture263_g83325) = _MaskTex11;
				SamplerState Sampler263_g83325 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83325 = temp_output_37_0_g83325;
				half3 WorldPosition263_g83325 = ase_worldPos;
				half3 WorldNormal263_g83325 = normalWS;
				half4 localSampleStochastic3D263_g83325 = SampleStochastic3D( Texture263_g83325 , Sampler263_g83325 , Coords263_g83325 , WorldPosition263_g83325 , WorldNormal263_g83325 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8861_g83242 = localSamplePlanar2D238_g83325;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8861_g83242 = localSamplePlanar3D246_g83325;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8861_g83242 = localSampleStochastic2D234_g83325;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8861_g83242 = localSampleStochastic3D263_g83325;
				#else
				float4 staticSwitch8861_g83242 = localSamplePlanar2D238_g83325;
				#endif
				float4 temp_output_7_0_g83278 = _MaskMin11;
				float4 temp_output_10_0_g83278 = ( _MaskMax11 - temp_output_7_0_g83278 );
				float4 temp_output_8819_0_g83242 = saturate( ( ( staticSwitch8861_g83242 - temp_output_7_0_g83278 ) / ( temp_output_10_0_g83278 + 0.0001 ) ) );
				half4 Masks_0312_g83275 = temp_output_8819_0_g83242;
				TEXTURE2D(Texture238_g83326) = _MaskTex12;
				SamplerState Sampler238_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_128836_g83242 = _Coords12;
				float4 temp_output_37_0_g83326 = Input_Coords_128836_g83242;
				half4 Coords238_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition238_g83326 = ase_worldPos;
				half4 localSamplePlanar2D238_g83326 = SamplePlanar2D( Texture238_g83326 , Sampler238_g83326 , Coords238_g83326 , WorldPosition238_g83326 );
				TEXTURE2D(Texture246_g83326) = _MaskTex12;
				SamplerState Sampler246_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition246_g83326 = ase_worldPos;
				half3 WorldNormal246_g83326 = normalWS;
				half4 localSamplePlanar3D246_g83326 = SamplePlanar3D( Texture246_g83326 , Sampler246_g83326 , Coords246_g83326 , WorldPosition246_g83326 , WorldNormal246_g83326 );
				TEXTURE2D(Texture234_g83326) = _MaskTex12;
				SamplerState Sampler234_g83326 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83326 = temp_output_37_0_g83326;
				float3 WorldPosition234_g83326 = ase_worldPos;
				float4 localSampleStochastic2D234_g83326 = SampleStochastic2D( Texture234_g83326 , Sampler234_g83326 , Coords234_g83326 , WorldPosition234_g83326 );
				TEXTURE2D(Texture263_g83326) = _MaskTex12;
				SamplerState Sampler263_g83326 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83326 = temp_output_37_0_g83326;
				half3 WorldPosition263_g83326 = ase_worldPos;
				half3 WorldNormal263_g83326 = normalWS;
				half4 localSampleStochastic3D263_g83326 = SampleStochastic3D( Texture263_g83326 , Sampler263_g83326 , Coords263_g83326 , WorldPosition263_g83326 , WorldNormal263_g83326 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8879_g83242 = localSamplePlanar2D238_g83326;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8879_g83242 = localSamplePlanar3D246_g83326;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8879_g83242 = localSampleStochastic2D234_g83326;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8879_g83242 = localSampleStochastic3D263_g83326;
				#else
				float4 staticSwitch8879_g83242 = localSamplePlanar2D238_g83326;
				#endif
				float4 temp_output_7_0_g83279 = _MaskMin12;
				float4 temp_output_10_0_g83279 = ( _MaskMax12 - temp_output_7_0_g83279 );
				float4 temp_output_8820_0_g83242 = saturate( ( ( staticSwitch8879_g83242 - temp_output_7_0_g83279 ) / ( temp_output_10_0_g83279 + 0.0001 ) ) );
				half4 Masks_0414_g83275 = temp_output_8820_0_g83242;
				float4 appendResult29_g83275 = (float4((Masks_015_g83275).z , (Masks_0210_g83275).z , (Masks_0312_g83275).z , (Masks_0414_g83275).z));
				half4 Control31_g83275 = Terrain_Control_127712_g83242;
				half4 Terrain_Height_128870_g83242 = ( appendResult29_g83275 * Control31_g83275 );
				float4 heights_127362_g83242 = Terrain_Height_128870_g83242;
				TEXTURE2D(Texture238_g83334) = _MaskTex13;
				SamplerState Sampler238_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_138960_g83242 = _Coords13;
				float4 temp_output_37_0_g83334 = Input_Coords_138960_g83242;
				half4 Coords238_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition238_g83334 = ase_worldPos;
				half4 localSamplePlanar2D238_g83334 = SamplePlanar2D( Texture238_g83334 , Sampler238_g83334 , Coords238_g83334 , WorldPosition238_g83334 );
				TEXTURE2D(Texture246_g83334) = _MaskTex13;
				SamplerState Sampler246_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition246_g83334 = ase_worldPos;
				half3 WorldNormal246_g83334 = normalWS;
				half4 localSamplePlanar3D246_g83334 = SamplePlanar3D( Texture246_g83334 , Sampler246_g83334 , Coords246_g83334 , WorldPosition246_g83334 , WorldNormal246_g83334 );
				TEXTURE2D(Texture234_g83334) = _MaskTex13;
				SamplerState Sampler234_g83334 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83334 = temp_output_37_0_g83334;
				float3 WorldPosition234_g83334 = ase_worldPos;
				float4 localSampleStochastic2D234_g83334 = SampleStochastic2D( Texture234_g83334 , Sampler234_g83334 , Coords234_g83334 , WorldPosition234_g83334 );
				TEXTURE2D(Texture263_g83334) = _MaskTex13;
				SamplerState Sampler263_g83334 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83334 = temp_output_37_0_g83334;
				half3 WorldPosition263_g83334 = ase_worldPos;
				half3 WorldNormal263_g83334 = normalWS;
				half4 localSampleStochastic3D263_g83334 = SampleStochastic3D( Texture263_g83334 , Sampler263_g83334 , Coords263_g83334 , WorldPosition263_g83334 , WorldNormal263_g83334 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch9000_g83242 = localSamplePlanar2D238_g83334;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch9000_g83242 = localSamplePlanar3D246_g83334;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch9000_g83242 = localSampleStochastic2D234_g83334;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch9000_g83242 = localSampleStochastic3D263_g83334;
				#else
				float4 staticSwitch9000_g83242 = localSamplePlanar2D238_g83334;
				#endif
				float4 temp_output_7_0_g83284 = _MaskMin13;
				float4 temp_output_10_0_g83284 = ( _MaskMax13 - temp_output_7_0_g83284 );
				float4 temp_output_8931_0_g83242 = saturate( ( ( staticSwitch9000_g83242 - temp_output_7_0_g83284 ) / ( temp_output_10_0_g83284 + 0.0001 ) ) );
				half4 Masks_015_g83285 = temp_output_8931_0_g83242;
				TEXTURE2D(Texture238_g83335) = _MaskTex14;
				SamplerState Sampler238_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_148961_g83242 = _Coords14;
				float4 temp_output_37_0_g83335 = Input_Coords_148961_g83242;
				half4 Coords238_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition238_g83335 = ase_worldPos;
				half4 localSamplePlanar2D238_g83335 = SamplePlanar2D( Texture238_g83335 , Sampler238_g83335 , Coords238_g83335 , WorldPosition238_g83335 );
				TEXTURE2D(Texture246_g83335) = _MaskTex14;
				SamplerState Sampler246_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition246_g83335 = ase_worldPos;
				half3 WorldNormal246_g83335 = normalWS;
				half4 localSamplePlanar3D246_g83335 = SamplePlanar3D( Texture246_g83335 , Sampler246_g83335 , Coords246_g83335 , WorldPosition246_g83335 , WorldNormal246_g83335 );
				TEXTURE2D(Texture234_g83335) = _MaskTex14;
				SamplerState Sampler234_g83335 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83335 = temp_output_37_0_g83335;
				float3 WorldPosition234_g83335 = ase_worldPos;
				float4 localSampleStochastic2D234_g83335 = SampleStochastic2D( Texture234_g83335 , Sampler234_g83335 , Coords234_g83335 , WorldPosition234_g83335 );
				TEXTURE2D(Texture263_g83335) = _MaskTex14;
				SamplerState Sampler263_g83335 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83335 = temp_output_37_0_g83335;
				half3 WorldPosition263_g83335 = ase_worldPos;
				half3 WorldNormal263_g83335 = normalWS;
				half4 localSampleStochastic3D263_g83335 = SampleStochastic3D( Texture263_g83335 , Sampler263_g83335 , Coords263_g83335 , WorldPosition263_g83335 , WorldNormal263_g83335 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch9001_g83242 = localSamplePlanar2D238_g83335;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch9001_g83242 = localSamplePlanar3D246_g83335;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch9001_g83242 = localSampleStochastic2D234_g83335;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch9001_g83242 = localSampleStochastic3D263_g83335;
				#else
				float4 staticSwitch9001_g83242 = localSamplePlanar2D238_g83335;
				#endif
				float4 temp_output_7_0_g83287 = _MaskMin14;
				float4 temp_output_10_0_g83287 = ( _MaskMax14 - temp_output_7_0_g83287 );
				float4 temp_output_8934_0_g83242 = saturate( ( ( staticSwitch9001_g83242 - temp_output_7_0_g83287 ) / ( temp_output_10_0_g83287 + 0.0001 ) ) );
				half4 Masks_0210_g83285 = temp_output_8934_0_g83242;
				TEXTURE2D(Texture238_g83336) = _MaskTex15;
				SamplerState Sampler238_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_158962_g83242 = _Coords15;
				float4 temp_output_37_0_g83336 = Input_Coords_158962_g83242;
				half4 Coords238_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition238_g83336 = ase_worldPos;
				half4 localSamplePlanar2D238_g83336 = SamplePlanar2D( Texture238_g83336 , Sampler238_g83336 , Coords238_g83336 , WorldPosition238_g83336 );
				TEXTURE2D(Texture246_g83336) = _MaskTex15;
				SamplerState Sampler246_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition246_g83336 = ase_worldPos;
				half3 WorldNormal246_g83336 = normalWS;
				half4 localSamplePlanar3D246_g83336 = SamplePlanar3D( Texture246_g83336 , Sampler246_g83336 , Coords246_g83336 , WorldPosition246_g83336 , WorldNormal246_g83336 );
				TEXTURE2D(Texture234_g83336) = _MaskTex15;
				SamplerState Sampler234_g83336 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83336 = temp_output_37_0_g83336;
				float3 WorldPosition234_g83336 = ase_worldPos;
				float4 localSampleStochastic2D234_g83336 = SampleStochastic2D( Texture234_g83336 , Sampler234_g83336 , Coords234_g83336 , WorldPosition234_g83336 );
				TEXTURE2D(Texture263_g83336) = _MaskTex15;
				SamplerState Sampler263_g83336 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83336 = temp_output_37_0_g83336;
				half3 WorldPosition263_g83336 = ase_worldPos;
				half3 WorldNormal263_g83336 = normalWS;
				half4 localSampleStochastic3D263_g83336 = SampleStochastic3D( Texture263_g83336 , Sampler263_g83336 , Coords263_g83336 , WorldPosition263_g83336 , WorldNormal263_g83336 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch9002_g83242 = localSamplePlanar2D238_g83336;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch9002_g83242 = localSamplePlanar3D246_g83336;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch9002_g83242 = localSampleStochastic2D234_g83336;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch9002_g83242 = localSampleStochastic3D263_g83336;
				#else
				float4 staticSwitch9002_g83242 = localSamplePlanar2D238_g83336;
				#endif
				float4 temp_output_7_0_g83288 = _MaskMin15;
				float4 temp_output_10_0_g83288 = ( _MaskMax15 - temp_output_7_0_g83288 );
				float4 temp_output_8935_0_g83242 = saturate( ( ( staticSwitch9002_g83242 - temp_output_7_0_g83288 ) / ( temp_output_10_0_g83288 + 0.0001 ) ) );
				half4 Masks_0312_g83285 = temp_output_8935_0_g83242;
				TEXTURE2D(Texture238_g83337) = _MaskTex16;
				SamplerState Sampler238_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Input_Coords_168959_g83242 = _Coords16;
				float4 temp_output_37_0_g83337 = Input_Coords_168959_g83242;
				half4 Coords238_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition238_g83337 = ase_worldPos;
				half4 localSamplePlanar2D238_g83337 = SamplePlanar2D( Texture238_g83337 , Sampler238_g83337 , Coords238_g83337 , WorldPosition238_g83337 );
				TEXTURE2D(Texture246_g83337) = _MaskTex16;
				SamplerState Sampler246_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition246_g83337 = ase_worldPos;
				half3 WorldNormal246_g83337 = normalWS;
				half4 localSamplePlanar3D246_g83337 = SamplePlanar3D( Texture246_g83337 , Sampler246_g83337 , Coords246_g83337 , WorldPosition246_g83337 , WorldNormal246_g83337 );
				TEXTURE2D(Texture234_g83337) = _MaskTex16;
				SamplerState Sampler234_g83337 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83337 = temp_output_37_0_g83337;
				float3 WorldPosition234_g83337 = ase_worldPos;
				float4 localSampleStochastic2D234_g83337 = SampleStochastic2D( Texture234_g83337 , Sampler234_g83337 , Coords234_g83337 , WorldPosition234_g83337 );
				TEXTURE2D(Texture263_g83337) = _MaskTex16;
				SamplerState Sampler263_g83337 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83337 = temp_output_37_0_g83337;
				half3 WorldPosition263_g83337 = ase_worldPos;
				half3 WorldNormal263_g83337 = normalWS;
				half4 localSampleStochastic3D263_g83337 = SampleStochastic3D( Texture263_g83337 , Sampler263_g83337 , Coords263_g83337 , WorldPosition263_g83337 , WorldNormal263_g83337 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch9003_g83242 = localSamplePlanar2D238_g83337;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch9003_g83242 = localSamplePlanar3D246_g83337;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch9003_g83242 = localSampleStochastic2D234_g83337;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch9003_g83242 = localSampleStochastic3D263_g83337;
				#else
				float4 staticSwitch9003_g83242 = localSamplePlanar2D238_g83337;
				#endif
				float4 temp_output_7_0_g83289 = _MaskMin16;
				float4 temp_output_10_0_g83289 = ( _MaskMax16 - temp_output_7_0_g83289 );
				float4 temp_output_8936_0_g83242 = saturate( ( ( staticSwitch9003_g83242 - temp_output_7_0_g83289 ) / ( temp_output_10_0_g83289 + 0.0001 ) ) );
				half4 Masks_0414_g83285 = temp_output_8936_0_g83242;
				float4 appendResult29_g83285 = (float4((Masks_015_g83285).z , (Masks_0210_g83285).z , (Masks_0312_g83285).z , (Masks_0414_g83285).z));
				half4 Control31_g83285 = Terrain_Control_167711_g83242;
				half4 Terrain_Height_169015_g83242 = ( appendResult29_g83285 * Control31_g83285 );
				float4 heights_167362_g83242 = Terrain_Height_169015_g83242;
				float heightTransition7362_g83242 = ( 1.0 - _TerrainHeightBlendValue );
				float4 weights_047362_g83242 = float4( 0,0,0,0 );
				float4 weights_087362_g83242 = float4( 0,0,0,0 );
				float4 weights_127362_g83242 = float4( 0,0,0,0 );
				float4 weights_167362_g83242 = float4( 0,0,0,0 );
				{
				//Modified version of the HDRP terrain height based blending
				float maxHeight = 0;
				float4 weightedHeights_04 = float4( 0,0,0,0 );
				float4 weightedHeights_08 = float4( 0,0,0,0 );
				float4 weightedHeights_12 = float4( 0,0,0,0 );
				float4 weightedHeights_16 = float4( 0,0,0,0 );
				maxHeight = heights_047362_g83242.x;
				maxHeight = max(maxHeight, heights_047362_g83242.y);
				maxHeight = max(maxHeight, heights_047362_g83242.z);
				maxHeight = max(maxHeight, heights_047362_g83242.w);
				#ifdef TVE_TERRAIN_08
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				#endif
				#ifdef TVE_TERRAIN_12
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				maxHeight = max(maxHeight, heights_127362_g83242.x);
				maxHeight = max(maxHeight, heights_127362_g83242.y);
				maxHeight = max(maxHeight, heights_127362_g83242.z);
				maxHeight = max(maxHeight, heights_127362_g83242.w);
				#endif
				#ifdef TVE_TERRAIN_16
				maxHeight = max(maxHeight, heights_087362_g83242.x);
				maxHeight = max(maxHeight, heights_087362_g83242.y);
				maxHeight = max(maxHeight, heights_087362_g83242.z);
				maxHeight = max(maxHeight, heights_087362_g83242.w);
				maxHeight = max(maxHeight, heights_127362_g83242.x);
				maxHeight = max(maxHeight, heights_127362_g83242.y);
				maxHeight = max(maxHeight, heights_127362_g83242.z);
				maxHeight = max(maxHeight, heights_127362_g83242.w);
				maxHeight = max(maxHeight, heights_167362_g83242.x);
				maxHeight = max(maxHeight, heights_167362_g83242.y);
				maxHeight = max(maxHeight, heights_167362_g83242.z);
				maxHeight = max(maxHeight, heights_167362_g83242.w);
				#endif
				float transition = max(heightTransition7362_g83242, 0.01);
				weightedHeights_04 = float4 ( heights_047362_g83242.x, heights_047362_g83242.y, heights_047362_g83242.z, heights_047362_g83242.w );
				weightedHeights_04 = weightedHeights_04 - maxHeight.xxxx;
				weightedHeights_04 = (max(0, weightedHeights_04 + transition) + 1e-6) * control_047362_g83242;
				#ifdef TVE_TERRAIN_08
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				#endif
				#ifdef TVE_TERRAIN_12
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				weightedHeights_12 = float4 ( heights_127362_g83242.x, heights_127362_g83242.y, heights_127362_g83242.z, heights_127362_g83242.w );
				weightedHeights_12 = weightedHeights_12 - maxHeight.xxxx;
				weightedHeights_12 = (max(0, weightedHeights_12 + transition) + 1e-6) * control_127362_g83242;
				#endif
				#ifdef TVE_TERRAIN_16
				weightedHeights_08 = float4 ( heights_087362_g83242.x, heights_087362_g83242.y, heights_087362_g83242.z, heights_087362_g83242.w );
				weightedHeights_08 = weightedHeights_08 - maxHeight.xxxx;
				weightedHeights_08 = (max(0, weightedHeights_08 + transition) + 1e-6) * control_087362_g83242;
				weightedHeights_12 = float4 ( heights_127362_g83242.x, heights_127362_g83242.y, heights_127362_g83242.z, heights_127362_g83242.w );
				weightedHeights_12 = weightedHeights_12 - maxHeight.xxxx;
				weightedHeights_12 = (max(0, weightedHeights_12 + transition) + 1e-6) * control_127362_g83242;
				weightedHeights_16 = float4 ( heights_167362_g83242.x, heights_167362_g83242.y, heights_167362_g83242.z, heights_167362_g83242.w );
				weightedHeights_16 = weightedHeights_16 - maxHeight.xxxx;
				weightedHeights_16 = (max(0, weightedHeights_16 + transition) + 1e-6) * control_167362_g83242;
				#endif
				float sumHeight_04 = weightedHeights_04.x + weightedHeights_04.y + weightedHeights_04.z + weightedHeights_04.w;
				float sumHeight_08 = weightedHeights_08.x + weightedHeights_08.y + weightedHeights_08.z + weightedHeights_08.w;
				float sumHeight_12 = weightedHeights_12.x + weightedHeights_12.y + weightedHeights_12.z + weightedHeights_12.w;
				float sumHeight_16 = weightedHeights_16.x + weightedHeights_16.y + weightedHeights_16.z + weightedHeights_16.w;
				float sumHeight = sumHeight_04 + sumHeight_08 + sumHeight_12 + sumHeight_16;
				weights_047362_g83242 = weightedHeights_04 / sumHeight.xxxx;
				#ifdef TVE_TERRAIN_08
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				#endif
				#ifdef TVE_TERRAIN_12
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				weights_127362_g83242 = weightedHeights_12 / sumHeight.xxxx;
				#endif
				#ifdef TVE_TERRAIN_16
				weights_087362_g83242 = weightedHeights_08 / sumHeight.xxxx;
				weights_127362_g83242 = weightedHeights_12 / sumHeight.xxxx;
				weights_167362_g83242 = weightedHeights_16 / sumHeight.xxxx;
				#endif
				}
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8792_g83242 = weights_047362_g83242;
				#else
				float4 staticSwitch8792_g83242 = control_047362_g83242;
				#endif
				half4 Terrain_Weights_046781_g83242 = staticSwitch8792_g83242;
				half4 Weights52_g83255 = Terrain_Weights_046781_g83242;
				TEXTURE2D(Texture238_g83339) = _AlbedoTex1;
				SamplerState Sampler238_g83339 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83339 = Input_Coords_016785_g83242;
				half4 Coords238_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition238_g83339 = ase_worldPos;
				half4 localSamplePlanar2D238_g83339 = SamplePlanar2D( Texture238_g83339 , Sampler238_g83339 , Coords238_g83339 , WorldPosition238_g83339 );
				TEXTURE2D(Texture246_g83339) = _AlbedoTex1;
				SamplerState Sampler246_g83339 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition246_g83339 = ase_worldPos;
				half3 WorldNormal246_g83339 = normalWS;
				half4 localSamplePlanar3D246_g83339 = SamplePlanar3D( Texture246_g83339 , Sampler246_g83339 , Coords246_g83339 , WorldPosition246_g83339 , WorldNormal246_g83339 );
				TEXTURE2D(Texture234_g83339) = _AlbedoTex1;
				SamplerState Sampler234_g83339 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83339 = temp_output_37_0_g83339;
				float3 WorldPosition234_g83339 = ase_worldPos;
				float4 localSampleStochastic2D234_g83339 = SampleStochastic2D( Texture234_g83339 , Sampler234_g83339 , Coords234_g83339 , WorldPosition234_g83339 );
				TEXTURE2D(Texture263_g83339) = _AlbedoTex1;
				SamplerState Sampler263_g83339 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83339 = temp_output_37_0_g83339;
				half3 WorldPosition263_g83339 = ase_worldPos;
				half3 WorldNormal263_g83339 = normalWS;
				half4 localSampleStochastic3D263_g83339 = SampleStochastic3D( Texture263_g83339 , Sampler263_g83339 , Coords263_g83339 , WorldPosition263_g83339 , WorldNormal263_g83339 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8614_g83242 = localSamplePlanar2D238_g83339;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8614_g83242 = localSamplePlanar3D246_g83339;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8614_g83242 = localSampleStochastic2D234_g83339;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8614_g83242 = localSampleStochastic3D263_g83339;
				#else
				float4 staticSwitch8614_g83242 = localSamplePlanar2D238_g83339;
				#endif
				half4 Layer133_g83255 = staticSwitch8614_g83242;
				TEXTURE2D(Texture238_g83292) = _AlbedoTex2;
				SamplerState Sampler238_g83292 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83292 = Input_Coords_026787_g83242;
				half4 Coords238_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition238_g83292 = ase_worldPos;
				half4 localSamplePlanar2D238_g83292 = SamplePlanar2D( Texture238_g83292 , Sampler238_g83292 , Coords238_g83292 , WorldPosition238_g83292 );
				TEXTURE2D(Texture246_g83292) = _AlbedoTex2;
				SamplerState Sampler246_g83292 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition246_g83292 = ase_worldPos;
				half3 WorldNormal246_g83292 = normalWS;
				half4 localSamplePlanar3D246_g83292 = SamplePlanar3D( Texture246_g83292 , Sampler246_g83292 , Coords246_g83292 , WorldPosition246_g83292 , WorldNormal246_g83292 );
				TEXTURE2D(Texture234_g83292) = _AlbedoTex2;
				SamplerState Sampler234_g83292 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83292 = temp_output_37_0_g83292;
				float3 WorldPosition234_g83292 = ase_worldPos;
				float4 localSampleStochastic2D234_g83292 = SampleStochastic2D( Texture234_g83292 , Sampler234_g83292 , Coords234_g83292 , WorldPosition234_g83292 );
				TEXTURE2D(Texture263_g83292) = _AlbedoTex2;
				SamplerState Sampler263_g83292 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83292 = temp_output_37_0_g83292;
				half3 WorldPosition263_g83292 = ase_worldPos;
				half3 WorldNormal263_g83292 = normalWS;
				half4 localSampleStochastic3D263_g83292 = SampleStochastic3D( Texture263_g83292 , Sampler263_g83292 , Coords263_g83292 , WorldPosition263_g83292 , WorldNormal263_g83292 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8629_g83242 = localSamplePlanar2D238_g83292;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8629_g83242 = localSamplePlanar3D246_g83292;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8629_g83242 = localSampleStochastic2D234_g83292;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8629_g83242 = localSampleStochastic3D263_g83292;
				#else
				float4 staticSwitch8629_g83242 = localSamplePlanar2D238_g83292;
				#endif
				half4 Layer237_g83255 = staticSwitch8629_g83242;
				TEXTURE2D(Texture238_g83293) = _AlbedoTex3;
				SamplerState Sampler238_g83293 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83293 = Input_Coords_036789_g83242;
				half4 Coords238_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition238_g83293 = ase_worldPos;
				half4 localSamplePlanar2D238_g83293 = SamplePlanar2D( Texture238_g83293 , Sampler238_g83293 , Coords238_g83293 , WorldPosition238_g83293 );
				TEXTURE2D(Texture246_g83293) = _AlbedoTex3;
				SamplerState Sampler246_g83293 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition246_g83293 = ase_worldPos;
				half3 WorldNormal246_g83293 = normalWS;
				half4 localSamplePlanar3D246_g83293 = SamplePlanar3D( Texture246_g83293 , Sampler246_g83293 , Coords246_g83293 , WorldPosition246_g83293 , WorldNormal246_g83293 );
				TEXTURE2D(Texture234_g83293) = _AlbedoTex3;
				SamplerState Sampler234_g83293 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83293 = temp_output_37_0_g83293;
				float3 WorldPosition234_g83293 = ase_worldPos;
				float4 localSampleStochastic2D234_g83293 = SampleStochastic2D( Texture234_g83293 , Sampler234_g83293 , Coords234_g83293 , WorldPosition234_g83293 );
				TEXTURE2D(Texture263_g83293) = _AlbedoTex3;
				SamplerState Sampler263_g83293 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83293 = temp_output_37_0_g83293;
				half3 WorldPosition263_g83293 = ase_worldPos;
				half3 WorldNormal263_g83293 = normalWS;
				half4 localSampleStochastic3D263_g83293 = SampleStochastic3D( Texture263_g83293 , Sampler263_g83293 , Coords263_g83293 , WorldPosition263_g83293 , WorldNormal263_g83293 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8630_g83242 = localSamplePlanar2D238_g83293;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8630_g83242 = localSamplePlanar3D246_g83293;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8630_g83242 = localSampleStochastic2D234_g83293;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8630_g83242 = localSampleStochastic3D263_g83293;
				#else
				float4 staticSwitch8630_g83242 = localSamplePlanar2D238_g83293;
				#endif
				half4 Layer338_g83255 = staticSwitch8630_g83242;
				TEXTURE2D(Texture238_g83294) = _AlbedoTex4;
				SamplerState Sampler238_g83294 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83294 = Input_Coords_046791_g83242;
				half4 Coords238_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition238_g83294 = ase_worldPos;
				half4 localSamplePlanar2D238_g83294 = SamplePlanar2D( Texture238_g83294 , Sampler238_g83294 , Coords238_g83294 , WorldPosition238_g83294 );
				TEXTURE2D(Texture246_g83294) = _AlbedoTex4;
				SamplerState Sampler246_g83294 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition246_g83294 = ase_worldPos;
				half3 WorldNormal246_g83294 = normalWS;
				half4 localSamplePlanar3D246_g83294 = SamplePlanar3D( Texture246_g83294 , Sampler246_g83294 , Coords246_g83294 , WorldPosition246_g83294 , WorldNormal246_g83294 );
				TEXTURE2D(Texture234_g83294) = _AlbedoTex4;
				SamplerState Sampler234_g83294 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83294 = temp_output_37_0_g83294;
				float3 WorldPosition234_g83294 = ase_worldPos;
				float4 localSampleStochastic2D234_g83294 = SampleStochastic2D( Texture234_g83294 , Sampler234_g83294 , Coords234_g83294 , WorldPosition234_g83294 );
				TEXTURE2D(Texture263_g83294) = _AlbedoTex4;
				SamplerState Sampler263_g83294 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83294 = temp_output_37_0_g83294;
				half3 WorldPosition263_g83294 = ase_worldPos;
				half3 WorldNormal263_g83294 = normalWS;
				half4 localSampleStochastic3D263_g83294 = SampleStochastic3D( Texture263_g83294 , Sampler263_g83294 , Coords263_g83294 , WorldPosition263_g83294 , WorldNormal263_g83294 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8631_g83242 = localSamplePlanar2D238_g83294;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8631_g83242 = localSamplePlanar3D246_g83294;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8631_g83242 = localSampleStochastic2D234_g83294;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8631_g83242 = localSampleStochastic3D263_g83294;
				#else
				float4 staticSwitch8631_g83242 = localSamplePlanar2D238_g83294;
				#endif
				half4 Layer439_g83255 = staticSwitch8631_g83242;
				float4 weightedBlendVar31_g83255 = Weights52_g83255;
				float4 weightedBlend31_g83255 = ( weightedBlendVar31_g83255.x*Layer133_g83255 + weightedBlendVar31_g83255.y*Layer237_g83255 + weightedBlendVar31_g83255.z*Layer338_g83255 + weightedBlendVar31_g83255.w*Layer439_g83255 );
				half4 Terrain_Albedo_047200_g83242 = weightedBlend31_g83255;
				half4 Layer_045_g83258 = Terrain_Albedo_047200_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8793_g83242 = weights_087362_g83242;
				#else
				float4 staticSwitch8793_g83242 = control_087362_g83242;
				#endif
				half4 Terrain_Weights_087340_g83242 = staticSwitch8793_g83242;
				half4 Weights52_g83262 = Terrain_Weights_087340_g83242;
				TEXTURE2D(Texture238_g83303) = _AlbedoTex5;
				SamplerState Sampler238_g83303 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83303 = Input_Coords_058750_g83242;
				half4 Coords238_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition238_g83303 = ase_worldPos;
				half4 localSamplePlanar2D238_g83303 = SamplePlanar2D( Texture238_g83303 , Sampler238_g83303 , Coords238_g83303 , WorldPosition238_g83303 );
				TEXTURE2D(Texture246_g83303) = _AlbedoTex5;
				SamplerState Sampler246_g83303 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition246_g83303 = ase_worldPos;
				half3 WorldNormal246_g83303 = normalWS;
				half4 localSamplePlanar3D246_g83303 = SamplePlanar3D( Texture246_g83303 , Sampler246_g83303 , Coords246_g83303 , WorldPosition246_g83303 , WorldNormal246_g83303 );
				TEXTURE2D(Texture234_g83303) = _AlbedoTex5;
				SamplerState Sampler234_g83303 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83303 = temp_output_37_0_g83303;
				float3 WorldPosition234_g83303 = ase_worldPos;
				float4 localSampleStochastic2D234_g83303 = SampleStochastic2D( Texture234_g83303 , Sampler234_g83303 , Coords234_g83303 , WorldPosition234_g83303 );
				TEXTURE2D(Texture263_g83303) = _AlbedoTex5;
				SamplerState Sampler263_g83303 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83303 = temp_output_37_0_g83303;
				half3 WorldPosition263_g83303 = ase_worldPos;
				half3 WorldNormal263_g83303 = normalWS;
				half4 localSampleStochastic3D263_g83303 = SampleStochastic3D( Texture263_g83303 , Sampler263_g83303 , Coords263_g83303 , WorldPosition263_g83303 , WorldNormal263_g83303 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8690_g83242 = localSamplePlanar2D238_g83303;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8690_g83242 = localSamplePlanar3D246_g83303;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8690_g83242 = localSampleStochastic2D234_g83303;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8690_g83242 = localSampleStochastic3D263_g83303;
				#else
				float4 staticSwitch8690_g83242 = localSamplePlanar2D238_g83303;
				#endif
				half4 Layer133_g83262 = staticSwitch8690_g83242;
				TEXTURE2D(Texture238_g83304) = _AlbedoTex6;
				SamplerState Sampler238_g83304 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83304 = Input_Coords_068751_g83242;
				half4 Coords238_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition238_g83304 = ase_worldPos;
				half4 localSamplePlanar2D238_g83304 = SamplePlanar2D( Texture238_g83304 , Sampler238_g83304 , Coords238_g83304 , WorldPosition238_g83304 );
				TEXTURE2D(Texture246_g83304) = _AlbedoTex6;
				SamplerState Sampler246_g83304 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition246_g83304 = ase_worldPos;
				half3 WorldNormal246_g83304 = normalWS;
				half4 localSamplePlanar3D246_g83304 = SamplePlanar3D( Texture246_g83304 , Sampler246_g83304 , Coords246_g83304 , WorldPosition246_g83304 , WorldNormal246_g83304 );
				TEXTURE2D(Texture234_g83304) = _AlbedoTex6;
				SamplerState Sampler234_g83304 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83304 = temp_output_37_0_g83304;
				float3 WorldPosition234_g83304 = ase_worldPos;
				float4 localSampleStochastic2D234_g83304 = SampleStochastic2D( Texture234_g83304 , Sampler234_g83304 , Coords234_g83304 , WorldPosition234_g83304 );
				TEXTURE2D(Texture263_g83304) = _AlbedoTex6;
				SamplerState Sampler263_g83304 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83304 = temp_output_37_0_g83304;
				half3 WorldPosition263_g83304 = ase_worldPos;
				half3 WorldNormal263_g83304 = normalWS;
				half4 localSampleStochastic3D263_g83304 = SampleStochastic3D( Texture263_g83304 , Sampler263_g83304 , Coords263_g83304 , WorldPosition263_g83304 , WorldNormal263_g83304 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8691_g83242 = localSamplePlanar2D238_g83304;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8691_g83242 = localSamplePlanar3D246_g83304;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8691_g83242 = localSampleStochastic2D234_g83304;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8691_g83242 = localSampleStochastic3D263_g83304;
				#else
				float4 staticSwitch8691_g83242 = localSamplePlanar2D238_g83304;
				#endif
				half4 Layer237_g83262 = staticSwitch8691_g83242;
				TEXTURE2D(Texture238_g83305) = _AlbedoTex7;
				SamplerState Sampler238_g83305 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83305 = Input_Coords_078752_g83242;
				half4 Coords238_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition238_g83305 = ase_worldPos;
				half4 localSamplePlanar2D238_g83305 = SamplePlanar2D( Texture238_g83305 , Sampler238_g83305 , Coords238_g83305 , WorldPosition238_g83305 );
				TEXTURE2D(Texture246_g83305) = _AlbedoTex7;
				SamplerState Sampler246_g83305 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition246_g83305 = ase_worldPos;
				half3 WorldNormal246_g83305 = normalWS;
				half4 localSamplePlanar3D246_g83305 = SamplePlanar3D( Texture246_g83305 , Sampler246_g83305 , Coords246_g83305 , WorldPosition246_g83305 , WorldNormal246_g83305 );
				TEXTURE2D(Texture234_g83305) = _AlbedoTex7;
				SamplerState Sampler234_g83305 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83305 = temp_output_37_0_g83305;
				float3 WorldPosition234_g83305 = ase_worldPos;
				float4 localSampleStochastic2D234_g83305 = SampleStochastic2D( Texture234_g83305 , Sampler234_g83305 , Coords234_g83305 , WorldPosition234_g83305 );
				TEXTURE2D(Texture263_g83305) = _AlbedoTex7;
				SamplerState Sampler263_g83305 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83305 = temp_output_37_0_g83305;
				half3 WorldPosition263_g83305 = ase_worldPos;
				half3 WorldNormal263_g83305 = normalWS;
				half4 localSampleStochastic3D263_g83305 = SampleStochastic3D( Texture263_g83305 , Sampler263_g83305 , Coords263_g83305 , WorldPosition263_g83305 , WorldNormal263_g83305 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8692_g83242 = localSamplePlanar2D238_g83305;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8692_g83242 = localSamplePlanar3D246_g83305;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8692_g83242 = localSampleStochastic2D234_g83305;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8692_g83242 = localSampleStochastic3D263_g83305;
				#else
				float4 staticSwitch8692_g83242 = localSamplePlanar2D238_g83305;
				#endif
				half4 Layer338_g83262 = staticSwitch8692_g83242;
				TEXTURE2D(Texture238_g83306) = _AlbedoTex8;
				SamplerState Sampler238_g83306 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83306 = Input_Coords_088749_g83242;
				half4 Coords238_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition238_g83306 = ase_worldPos;
				half4 localSamplePlanar2D238_g83306 = SamplePlanar2D( Texture238_g83306 , Sampler238_g83306 , Coords238_g83306 , WorldPosition238_g83306 );
				TEXTURE2D(Texture246_g83306) = _AlbedoTex8;
				SamplerState Sampler246_g83306 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition246_g83306 = ase_worldPos;
				half3 WorldNormal246_g83306 = normalWS;
				half4 localSamplePlanar3D246_g83306 = SamplePlanar3D( Texture246_g83306 , Sampler246_g83306 , Coords246_g83306 , WorldPosition246_g83306 , WorldNormal246_g83306 );
				TEXTURE2D(Texture234_g83306) = _AlbedoTex8;
				SamplerState Sampler234_g83306 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83306 = temp_output_37_0_g83306;
				float3 WorldPosition234_g83306 = ase_worldPos;
				float4 localSampleStochastic2D234_g83306 = SampleStochastic2D( Texture234_g83306 , Sampler234_g83306 , Coords234_g83306 , WorldPosition234_g83306 );
				TEXTURE2D(Texture263_g83306) = _AlbedoTex8;
				SamplerState Sampler263_g83306 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83306 = temp_output_37_0_g83306;
				half3 WorldPosition263_g83306 = ase_worldPos;
				half3 WorldNormal263_g83306 = normalWS;
				half4 localSampleStochastic3D263_g83306 = SampleStochastic3D( Texture263_g83306 , Sampler263_g83306 , Coords263_g83306 , WorldPosition263_g83306 , WorldNormal263_g83306 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8693_g83242 = localSamplePlanar2D238_g83306;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8693_g83242 = localSamplePlanar3D246_g83306;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8693_g83242 = localSampleStochastic2D234_g83306;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8693_g83242 = localSampleStochastic3D263_g83306;
				#else
				float4 staticSwitch8693_g83242 = localSamplePlanar2D238_g83306;
				#endif
				half4 Layer439_g83262 = staticSwitch8693_g83242;
				float4 weightedBlendVar31_g83262 = Weights52_g83262;
				float4 weightedBlend31_g83262 = ( weightedBlendVar31_g83262.x*Layer133_g83262 + weightedBlendVar31_g83262.y*Layer237_g83262 + weightedBlendVar31_g83262.z*Layer338_g83262 + weightedBlendVar31_g83262.w*Layer439_g83262 );
				half4 Terrain_Albedo_088665_g83242 = weightedBlend31_g83262;
				half4 Layer_0810_g83258 = Terrain_Albedo_088665_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8794_g83242 = weights_127362_g83242;
				#else
				float4 staticSwitch8794_g83242 = control_127362_g83242;
				#endif
				half4 Terrain_Weights_127710_g83242 = staticSwitch8794_g83242;
				half4 Weights52_g83272 = Terrain_Weights_127710_g83242;
				TEXTURE2D(Texture238_g83315) = _AlbedoTex9;
				SamplerState Sampler238_g83315 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83315 = Input_Coords_098833_g83242;
				half4 Coords238_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition238_g83315 = ase_worldPos;
				half4 localSamplePlanar2D238_g83315 = SamplePlanar2D( Texture238_g83315 , Sampler238_g83315 , Coords238_g83315 , WorldPosition238_g83315 );
				TEXTURE2D(Texture246_g83315) = _AlbedoTex9;
				SamplerState Sampler246_g83315 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition246_g83315 = ase_worldPos;
				half3 WorldNormal246_g83315 = normalWS;
				half4 localSamplePlanar3D246_g83315 = SamplePlanar3D( Texture246_g83315 , Sampler246_g83315 , Coords246_g83315 , WorldPosition246_g83315 , WorldNormal246_g83315 );
				TEXTURE2D(Texture234_g83315) = _AlbedoTex9;
				SamplerState Sampler234_g83315 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83315 = temp_output_37_0_g83315;
				float3 WorldPosition234_g83315 = ase_worldPos;
				float4 localSampleStochastic2D234_g83315 = SampleStochastic2D( Texture234_g83315 , Sampler234_g83315 , Coords234_g83315 , WorldPosition234_g83315 );
				TEXTURE2D(Texture263_g83315) = _AlbedoTex9;
				SamplerState Sampler263_g83315 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83315 = temp_output_37_0_g83315;
				half3 WorldPosition263_g83315 = ase_worldPos;
				half3 WorldNormal263_g83315 = normalWS;
				half4 localSampleStochastic3D263_g83315 = SampleStochastic3D( Texture263_g83315 , Sampler263_g83315 , Coords263_g83315 , WorldPosition263_g83315 , WorldNormal263_g83315 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8872_g83242 = localSamplePlanar2D238_g83315;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8872_g83242 = localSamplePlanar3D246_g83315;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8872_g83242 = localSampleStochastic2D234_g83315;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8872_g83242 = localSampleStochastic3D263_g83315;
				#else
				float4 staticSwitch8872_g83242 = localSamplePlanar2D238_g83315;
				#endif
				half4 Layer133_g83272 = staticSwitch8872_g83242;
				TEXTURE2D(Texture238_g83316) = _AlbedoTex10;
				SamplerState Sampler238_g83316 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83316 = Input_Coords_108834_g83242;
				half4 Coords238_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition238_g83316 = ase_worldPos;
				half4 localSamplePlanar2D238_g83316 = SamplePlanar2D( Texture238_g83316 , Sampler238_g83316 , Coords238_g83316 , WorldPosition238_g83316 );
				TEXTURE2D(Texture246_g83316) = _AlbedoTex10;
				SamplerState Sampler246_g83316 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition246_g83316 = ase_worldPos;
				half3 WorldNormal246_g83316 = normalWS;
				half4 localSamplePlanar3D246_g83316 = SamplePlanar3D( Texture246_g83316 , Sampler246_g83316 , Coords246_g83316 , WorldPosition246_g83316 , WorldNormal246_g83316 );
				TEXTURE2D(Texture234_g83316) = _AlbedoTex10;
				SamplerState Sampler234_g83316 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83316 = temp_output_37_0_g83316;
				float3 WorldPosition234_g83316 = ase_worldPos;
				float4 localSampleStochastic2D234_g83316 = SampleStochastic2D( Texture234_g83316 , Sampler234_g83316 , Coords234_g83316 , WorldPosition234_g83316 );
				TEXTURE2D(Texture263_g83316) = _AlbedoTex10;
				SamplerState Sampler263_g83316 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83316 = temp_output_37_0_g83316;
				half3 WorldPosition263_g83316 = ase_worldPos;
				half3 WorldNormal263_g83316 = normalWS;
				half4 localSampleStochastic3D263_g83316 = SampleStochastic3D( Texture263_g83316 , Sampler263_g83316 , Coords263_g83316 , WorldPosition263_g83316 , WorldNormal263_g83316 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8873_g83242 = localSamplePlanar2D238_g83316;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8873_g83242 = localSamplePlanar3D246_g83316;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8873_g83242 = localSampleStochastic2D234_g83316;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8873_g83242 = localSampleStochastic3D263_g83316;
				#else
				float4 staticSwitch8873_g83242 = localSamplePlanar2D238_g83316;
				#endif
				half4 Layer237_g83272 = staticSwitch8873_g83242;
				TEXTURE2D(Texture238_g83317) = _AlbedoTex11;
				SamplerState Sampler238_g83317 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83317 = Input_Coords_118835_g83242;
				half4 Coords238_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition238_g83317 = ase_worldPos;
				half4 localSamplePlanar2D238_g83317 = SamplePlanar2D( Texture238_g83317 , Sampler238_g83317 , Coords238_g83317 , WorldPosition238_g83317 );
				TEXTURE2D(Texture246_g83317) = _AlbedoTex11;
				SamplerState Sampler246_g83317 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition246_g83317 = ase_worldPos;
				half3 WorldNormal246_g83317 = normalWS;
				half4 localSamplePlanar3D246_g83317 = SamplePlanar3D( Texture246_g83317 , Sampler246_g83317 , Coords246_g83317 , WorldPosition246_g83317 , WorldNormal246_g83317 );
				TEXTURE2D(Texture234_g83317) = _AlbedoTex11;
				SamplerState Sampler234_g83317 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83317 = temp_output_37_0_g83317;
				float3 WorldPosition234_g83317 = ase_worldPos;
				float4 localSampleStochastic2D234_g83317 = SampleStochastic2D( Texture234_g83317 , Sampler234_g83317 , Coords234_g83317 , WorldPosition234_g83317 );
				TEXTURE2D(Texture263_g83317) = _AlbedoTex11;
				SamplerState Sampler263_g83317 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83317 = temp_output_37_0_g83317;
				half3 WorldPosition263_g83317 = ase_worldPos;
				half3 WorldNormal263_g83317 = normalWS;
				half4 localSampleStochastic3D263_g83317 = SampleStochastic3D( Texture263_g83317 , Sampler263_g83317 , Coords263_g83317 , WorldPosition263_g83317 , WorldNormal263_g83317 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8874_g83242 = localSamplePlanar2D238_g83317;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8874_g83242 = localSamplePlanar3D246_g83317;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8874_g83242 = localSampleStochastic2D234_g83317;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8874_g83242 = localSampleStochastic3D263_g83317;
				#else
				float4 staticSwitch8874_g83242 = localSamplePlanar2D238_g83317;
				#endif
				half4 Layer338_g83272 = staticSwitch8874_g83242;
				TEXTURE2D(Texture238_g83318) = _AlbedoTex12;
				SamplerState Sampler238_g83318 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83318 = Input_Coords_128836_g83242;
				half4 Coords238_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition238_g83318 = ase_worldPos;
				half4 localSamplePlanar2D238_g83318 = SamplePlanar2D( Texture238_g83318 , Sampler238_g83318 , Coords238_g83318 , WorldPosition238_g83318 );
				TEXTURE2D(Texture246_g83318) = _AlbedoTex12;
				SamplerState Sampler246_g83318 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition246_g83318 = ase_worldPos;
				half3 WorldNormal246_g83318 = normalWS;
				half4 localSamplePlanar3D246_g83318 = SamplePlanar3D( Texture246_g83318 , Sampler246_g83318 , Coords246_g83318 , WorldPosition246_g83318 , WorldNormal246_g83318 );
				TEXTURE2D(Texture234_g83318) = _AlbedoTex12;
				SamplerState Sampler234_g83318 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83318 = temp_output_37_0_g83318;
				float3 WorldPosition234_g83318 = ase_worldPos;
				float4 localSampleStochastic2D234_g83318 = SampleStochastic2D( Texture234_g83318 , Sampler234_g83318 , Coords234_g83318 , WorldPosition234_g83318 );
				TEXTURE2D(Texture263_g83318) = _AlbedoTex12;
				SamplerState Sampler263_g83318 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83318 = temp_output_37_0_g83318;
				half3 WorldPosition263_g83318 = ase_worldPos;
				half3 WorldNormal263_g83318 = normalWS;
				half4 localSampleStochastic3D263_g83318 = SampleStochastic3D( Texture263_g83318 , Sampler263_g83318 , Coords263_g83318 , WorldPosition263_g83318 , WorldNormal263_g83318 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8875_g83242 = localSamplePlanar2D238_g83318;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8875_g83242 = localSamplePlanar3D246_g83318;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8875_g83242 = localSampleStochastic2D234_g83318;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8875_g83242 = localSampleStochastic3D263_g83318;
				#else
				float4 staticSwitch8875_g83242 = localSamplePlanar2D238_g83318;
				#endif
				half4 Layer439_g83272 = staticSwitch8875_g83242;
				float4 weightedBlendVar31_g83272 = Weights52_g83272;
				float4 weightedBlend31_g83272 = ( weightedBlendVar31_g83272.x*Layer133_g83272 + weightedBlendVar31_g83272.y*Layer237_g83272 + weightedBlendVar31_g83272.z*Layer338_g83272 + weightedBlendVar31_g83272.w*Layer439_g83272 );
				half4 Terrain_Albedo_128851_g83242 = weightedBlend31_g83272;
				half4 Layer_1243_g83258 = Terrain_Albedo_128851_g83242;
				#ifdef TVE_HEIGHT_BLEND
				float4 staticSwitch8795_g83242 = weights_167362_g83242;
				#else
				float4 staticSwitch8795_g83242 = control_167362_g83242;
				#endif
				half4 Terrain_Weights_167709_g83242 = staticSwitch8795_g83242;
				half4 Weights52_g83282 = Terrain_Weights_167709_g83242;
				TEXTURE2D(Texture238_g83327) = _AlbedoTex13;
				SamplerState Sampler238_g83327 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83327 = Input_Coords_138960_g83242;
				half4 Coords238_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition238_g83327 = ase_worldPos;
				half4 localSamplePlanar2D238_g83327 = SamplePlanar2D( Texture238_g83327 , Sampler238_g83327 , Coords238_g83327 , WorldPosition238_g83327 );
				TEXTURE2D(Texture246_g83327) = _AlbedoTex13;
				SamplerState Sampler246_g83327 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition246_g83327 = ase_worldPos;
				half3 WorldNormal246_g83327 = normalWS;
				half4 localSamplePlanar3D246_g83327 = SamplePlanar3D( Texture246_g83327 , Sampler246_g83327 , Coords246_g83327 , WorldPosition246_g83327 , WorldNormal246_g83327 );
				TEXTURE2D(Texture234_g83327) = _AlbedoTex13;
				SamplerState Sampler234_g83327 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83327 = temp_output_37_0_g83327;
				float3 WorldPosition234_g83327 = ase_worldPos;
				float4 localSampleStochastic2D234_g83327 = SampleStochastic2D( Texture234_g83327 , Sampler234_g83327 , Coords234_g83327 , WorldPosition234_g83327 );
				TEXTURE2D(Texture263_g83327) = _AlbedoTex13;
				SamplerState Sampler263_g83327 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83327 = temp_output_37_0_g83327;
				half3 WorldPosition263_g83327 = ase_worldPos;
				half3 WorldNormal263_g83327 = normalWS;
				half4 localSampleStochastic3D263_g83327 = SampleStochastic3D( Texture263_g83327 , Sampler263_g83327 , Coords263_g83327 , WorldPosition263_g83327 , WorldNormal263_g83327 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch8972_g83242 = localSamplePlanar2D238_g83327;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch8972_g83242 = localSamplePlanar3D246_g83327;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch8972_g83242 = localSampleStochastic2D234_g83327;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch8972_g83242 = localSampleStochastic3D263_g83327;
				#else
				float4 staticSwitch8972_g83242 = localSamplePlanar2D238_g83327;
				#endif
				half4 Layer133_g83282 = staticSwitch8972_g83242;
				TEXTURE2D(Texture238_g83328) = _AlbedoTex14;
				SamplerState Sampler238_g83328 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83328 = Input_Coords_148961_g83242;
				half4 Coords238_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition238_g83328 = ase_worldPos;
				half4 localSamplePlanar2D238_g83328 = SamplePlanar2D( Texture238_g83328 , Sampler238_g83328 , Coords238_g83328 , WorldPosition238_g83328 );
				TEXTURE2D(Texture246_g83328) = _AlbedoTex14;
				SamplerState Sampler246_g83328 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition246_g83328 = ase_worldPos;
				half3 WorldNormal246_g83328 = normalWS;
				half4 localSamplePlanar3D246_g83328 = SamplePlanar3D( Texture246_g83328 , Sampler246_g83328 , Coords246_g83328 , WorldPosition246_g83328 , WorldNormal246_g83328 );
				TEXTURE2D(Texture234_g83328) = _AlbedoTex14;
				SamplerState Sampler234_g83328 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83328 = temp_output_37_0_g83328;
				float3 WorldPosition234_g83328 = ase_worldPos;
				float4 localSampleStochastic2D234_g83328 = SampleStochastic2D( Texture234_g83328 , Sampler234_g83328 , Coords234_g83328 , WorldPosition234_g83328 );
				TEXTURE2D(Texture263_g83328) = _AlbedoTex14;
				SamplerState Sampler263_g83328 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83328 = temp_output_37_0_g83328;
				half3 WorldPosition263_g83328 = ase_worldPos;
				half3 WorldNormal263_g83328 = normalWS;
				half4 localSampleStochastic3D263_g83328 = SampleStochastic3D( Texture263_g83328 , Sampler263_g83328 , Coords263_g83328 , WorldPosition263_g83328 , WorldNormal263_g83328 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch8973_g83242 = localSamplePlanar2D238_g83328;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch8973_g83242 = localSamplePlanar3D246_g83328;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch8973_g83242 = localSampleStochastic2D234_g83328;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch8973_g83242 = localSampleStochastic3D263_g83328;
				#else
				float4 staticSwitch8973_g83242 = localSamplePlanar2D238_g83328;
				#endif
				half4 Layer237_g83282 = staticSwitch8973_g83242;
				TEXTURE2D(Texture238_g83329) = _AlbedoTex15;
				SamplerState Sampler238_g83329 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83329 = Input_Coords_158962_g83242;
				half4 Coords238_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition238_g83329 = ase_worldPos;
				half4 localSamplePlanar2D238_g83329 = SamplePlanar2D( Texture238_g83329 , Sampler238_g83329 , Coords238_g83329 , WorldPosition238_g83329 );
				TEXTURE2D(Texture246_g83329) = _AlbedoTex15;
				SamplerState Sampler246_g83329 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition246_g83329 = ase_worldPos;
				half3 WorldNormal246_g83329 = normalWS;
				half4 localSamplePlanar3D246_g83329 = SamplePlanar3D( Texture246_g83329 , Sampler246_g83329 , Coords246_g83329 , WorldPosition246_g83329 , WorldNormal246_g83329 );
				TEXTURE2D(Texture234_g83329) = _AlbedoTex15;
				SamplerState Sampler234_g83329 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83329 = temp_output_37_0_g83329;
				float3 WorldPosition234_g83329 = ase_worldPos;
				float4 localSampleStochastic2D234_g83329 = SampleStochastic2D( Texture234_g83329 , Sampler234_g83329 , Coords234_g83329 , WorldPosition234_g83329 );
				TEXTURE2D(Texture263_g83329) = _AlbedoTex15;
				SamplerState Sampler263_g83329 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83329 = temp_output_37_0_g83329;
				half3 WorldPosition263_g83329 = ase_worldPos;
				half3 WorldNormal263_g83329 = normalWS;
				half4 localSampleStochastic3D263_g83329 = SampleStochastic3D( Texture263_g83329 , Sampler263_g83329 , Coords263_g83329 , WorldPosition263_g83329 , WorldNormal263_g83329 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch8974_g83242 = localSamplePlanar2D238_g83329;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch8974_g83242 = localSamplePlanar3D246_g83329;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch8974_g83242 = localSampleStochastic2D234_g83329;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch8974_g83242 = localSampleStochastic3D263_g83329;
				#else
				float4 staticSwitch8974_g83242 = localSamplePlanar2D238_g83329;
				#endif
				half4 Layer338_g83282 = staticSwitch8974_g83242;
				TEXTURE2D(Texture238_g83330) = _AlbedoTex16;
				SamplerState Sampler238_g83330 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83330 = Input_Coords_168959_g83242;
				half4 Coords238_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition238_g83330 = ase_worldPos;
				half4 localSamplePlanar2D238_g83330 = SamplePlanar2D( Texture238_g83330 , Sampler238_g83330 , Coords238_g83330 , WorldPosition238_g83330 );
				TEXTURE2D(Texture246_g83330) = _AlbedoTex16;
				SamplerState Sampler246_g83330 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition246_g83330 = ase_worldPos;
				half3 WorldNormal246_g83330 = normalWS;
				half4 localSamplePlanar3D246_g83330 = SamplePlanar3D( Texture246_g83330 , Sampler246_g83330 , Coords246_g83330 , WorldPosition246_g83330 , WorldNormal246_g83330 );
				TEXTURE2D(Texture234_g83330) = _AlbedoTex16;
				SamplerState Sampler234_g83330 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83330 = temp_output_37_0_g83330;
				float3 WorldPosition234_g83330 = ase_worldPos;
				float4 localSampleStochastic2D234_g83330 = SampleStochastic2D( Texture234_g83330 , Sampler234_g83330 , Coords234_g83330 , WorldPosition234_g83330 );
				TEXTURE2D(Texture263_g83330) = _AlbedoTex16;
				SamplerState Sampler263_g83330 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83330 = temp_output_37_0_g83330;
				half3 WorldPosition263_g83330 = ase_worldPos;
				half3 WorldNormal263_g83330 = normalWS;
				half4 localSampleStochastic3D263_g83330 = SampleStochastic3D( Texture263_g83330 , Sampler263_g83330 , Coords263_g83330 , WorldPosition263_g83330 , WorldNormal263_g83330 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch8975_g83242 = localSamplePlanar2D238_g83330;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch8975_g83242 = localSamplePlanar3D246_g83330;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch8975_g83242 = localSampleStochastic2D234_g83330;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch8975_g83242 = localSampleStochastic3D263_g83330;
				#else
				float4 staticSwitch8975_g83242 = localSamplePlanar2D238_g83330;
				#endif
				half4 Layer439_g83282 = staticSwitch8975_g83242;
				float4 weightedBlendVar31_g83282 = Weights52_g83282;
				float4 weightedBlend31_g83282 = ( weightedBlendVar31_g83282.x*Layer133_g83282 + weightedBlendVar31_g83282.y*Layer237_g83282 + weightedBlendVar31_g83282.z*Layer338_g83282 + weightedBlendVar31_g83282.w*Layer439_g83282 );
				half4 Terrain_Albedo_168986_g83242 = weightedBlend31_g83282;
				half4 Layer_1644_g83258 = Terrain_Albedo_168986_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83258 = Layer_045_g83258;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 + Layer_1243_g83258 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83258 = ( Layer_045_g83258 + Layer_0810_g83258 + Layer_1243_g83258 + Layer_1644_g83258 );
				#else
				float4 staticSwitch40_g83258 = Layer_045_g83258;
				#endif
				half4 Blend_Albedo7468_g83242 = staticSwitch40_g83258;
				half4 Terrain_Albedo6800_g79798 = Blend_Albedo7468_g83242;
				half3 Blend_Albedo2808_g79798 = ( (Terrain_Albedo6800_g79798).xyz * (_TerrainColor).rgb );
				half3 Blend_Albedo_Tinted7319_g79798 = Blend_Albedo2808_g79798;
				float3 temp_output_3_0_g79843 = Blend_Albedo2808_g79798;
				float dotResult20_g79843 = dot( temp_output_3_0_g79843 , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Grayscale5939_g79798 = dotResult20_g79843;
				float3 temp_cast_8 = (Blend_Albedo_Grayscale5939_g79798).xxx;
				float temp_output_82_0_g79821 = _LayerColorsValue;
				float temp_output_19_0_g79825 = TVE_ColorsUsage[(int)temp_output_82_0_g79821];
				float4 temp_output_91_19_g79821 = TVE_ColorsCoords;
				float3 vertexToFrag7344_g79798 = packedInput.ase_texcoord8.xyz;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV94_g79821 = ( (temp_output_91_19_g79821).zw + ( (temp_output_91_19_g79821).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode83_g79821 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, UV94_g79821,temp_output_82_0_g79821, 0.0 );
				float4 temp_output_17_0_g79825 = tex2DArrayNode83_g79821;
				float4 temp_output_92_86_g79821 = TVE_ColorsParams;
				float4 temp_output_3_0_g79825 = temp_output_92_86_g79821;
				float4 ifLocalVar18_g79825 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79825 >= 0.5 )
				ifLocalVar18_g79825 = temp_output_17_0_g79825;
				else
				ifLocalVar18_g79825 = temp_output_3_0_g79825;
				float4 lerpResult22_g79825 = lerp( temp_output_3_0_g79825 , temp_output_17_0_g79825 , temp_output_19_0_g79825);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79825 = lerpResult22_g79825;
				#else
				float4 staticSwitch24_g79825 = ifLocalVar18_g79825;
				#endif
				half4 Global_Colors_Params5434_g79798 = staticSwitch24_g79825;
				float4 temp_output_346_0_g79804 = Global_Colors_Params5434_g79798;
				half Global_Colors_A1701_g79798 = saturate( (temp_output_346_0_g79804).w );
				half Colors_Influence3668_g79798 = Global_Colors_A1701_g79798;
				float temp_output_6306_0_g79798 = ( 1.0 - Colors_Influence3668_g79798 );
				float3 lerpResult3618_g79798 = lerp( Blend_Albedo_Tinted7319_g79798 , temp_cast_8 , ( 1.0 - ( temp_output_6306_0_g79798 * temp_output_6306_0_g79798 ) ));
				half3 Global_Colors_RGB1700_g79798 = (temp_output_346_0_g79804).xyz;
				half3 Colors_RGB1954_g79798 = ( Global_Colors_RGB1700_g79798 * 4.594794 * _ColorsIntensityValue );
				half4 Weights52_g83254 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83254 = _Specular1;
				half4 Layer237_g83254 = _Specular2;
				half4 Layer338_g83254 = _Specular3;
				half4 Layer439_g83254 = _Specular4;
				float4 weightedBlendVar31_g83254 = Weights52_g83254;
				float4 weightedBlend31_g83254 = ( weightedBlendVar31_g83254.x*Layer133_g83254 + weightedBlendVar31_g83254.y*Layer237_g83254 + weightedBlendVar31_g83254.z*Layer338_g83254 + weightedBlendVar31_g83254.w*Layer439_g83254 );
				half4 Terrain_Specular_047390_g83242 = weightedBlend31_g83254;
				half4 Layer_045_g83261 = Terrain_Specular_047390_g83242;
				half4 Weights52_g83271 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83271 = _Specular5;
				half4 Layer237_g83271 = _Specular6;
				half4 Layer338_g83271 = _Specular7;
				half4 Layer439_g83271 = _Specular8;
				float4 weightedBlendVar31_g83271 = Weights52_g83271;
				float4 weightedBlend31_g83271 = ( weightedBlendVar31_g83271.x*Layer133_g83271 + weightedBlendVar31_g83271.y*Layer237_g83271 + weightedBlendVar31_g83271.z*Layer338_g83271 + weightedBlendVar31_g83271.w*Layer439_g83271 );
				half4 Terrain_Specular_088745_g83242 = weightedBlend31_g83271;
				half4 Layer_0810_g83261 = Terrain_Specular_088745_g83242;
				half4 Weights52_g83281 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83281 = _Specular9;
				half4 Layer237_g83281 = _Specular10;
				half4 Layer338_g83281 = _Specular11;
				half4 Layer439_g83281 = _Specular12;
				float4 weightedBlendVar31_g83281 = Weights52_g83281;
				float4 weightedBlend31_g83281 = ( weightedBlendVar31_g83281.x*Layer133_g83281 + weightedBlendVar31_g83281.y*Layer237_g83281 + weightedBlendVar31_g83281.z*Layer338_g83281 + weightedBlendVar31_g83281.w*Layer439_g83281 );
				half4 Terrain_Specular_128869_g83242 = weightedBlend31_g83281;
				half4 Layer_1243_g83261 = Terrain_Specular_128869_g83242;
				half4 Weights52_g83291 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83291 = _Specular13;
				half4 Layer237_g83291 = _Specular14;
				half4 Layer338_g83291 = _Specular15;
				half4 Layer439_g83291 = _Specular16;
				float4 weightedBlendVar31_g83291 = Weights52_g83291;
				float4 weightedBlend31_g83291 = ( weightedBlendVar31_g83291.x*Layer133_g83291 + weightedBlendVar31_g83291.y*Layer237_g83291 + weightedBlendVar31_g83291.z*Layer338_g83291 + weightedBlendVar31_g83291.w*Layer439_g83291 );
				half4 Terrain_Specular_169019_g83242 = weightedBlend31_g83291;
				half4 Layer_1644_g83261 = Terrain_Specular_169019_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83261 = Layer_045_g83261;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 + Layer_1243_g83261 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83261 = ( Layer_045_g83261 + Layer_0810_g83261 + Layer_1243_g83261 + Layer_1644_g83261 );
				#else
				float4 staticSwitch40_g83261 = Layer_045_g83261;
				#endif
				half4 Blend_Specular7446_g83242 = staticSwitch40_g83261;
				half4 Terrain_Specular7322_g79798 = Blend_Specular7446_g83242;
				half Colors_Value3692_g79798 = ( (Terrain_Albedo6800_g79798).w * _GlobalColors * (Terrain_Specular7322_g79798).a );
				float clampResult6740_g79798 = clamp( saturate( ( Blend_Albedo_Grayscale5939_g79798 * 5.0 ) ) , 0.2 , 1.0 );
				half Blend_Albedo_Globals6410_g79798 = clampResult6740_g79798;
				float temp_output_7_0_g79846 = 0.1;
				float temp_output_10_0_g79846 = ( 0.2 - temp_output_7_0_g79846 );
				float lerpResult16_g79845 = lerp( 0.0 , saturate( ( ( ( Colors_Value3692_g79798 * Colors_Influence3668_g79798 * Blend_Albedo_Globals6410_g79798 ) - temp_output_7_0_g79846 ) / ( temp_output_10_0_g79846 + 0.0001 ) ) ) , TVE_IsEnabled);
				float3 lerpResult3628_g79798 = lerp( Blend_Albedo_Tinted7319_g79798 , ( lerpResult3618_g79798 * Colors_RGB1954_g79798 ) , lerpResult16_g79845);
				half3 Blend_Albedo_Colored_High6027_g79798 = lerpResult3628_g79798;
				half3 Blend_Albedo_Colored863_g79798 = Blend_Albedo_Colored_High6027_g79798;
				half3 Global_OverlayColor1758_g79798 = (TVE_OverlayColor).rgb;
				float temp_output_84_0_g79816 = _LayerExtrasValue;
				float temp_output_19_0_g79820 = TVE_ExtrasUsage[(int)temp_output_84_0_g79816];
				float4 temp_output_93_19_g79816 = TVE_ExtrasCoords;
				half2 UV96_g79816 = ( (temp_output_93_19_g79816).zw + ( (temp_output_93_19_g79816).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode48_g79816 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g79816,temp_output_84_0_g79816, 0.0 );
				float4 temp_output_17_0_g79820 = tex2DArrayNode48_g79816;
				float4 temp_output_94_85_g79816 = TVE_ExtrasParams;
				float4 temp_output_3_0_g79820 = temp_output_94_85_g79816;
				float4 ifLocalVar18_g79820 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79820 >= 0.5 )
				ifLocalVar18_g79820 = temp_output_17_0_g79820;
				else
				ifLocalVar18_g79820 = temp_output_3_0_g79820;
				float4 lerpResult22_g79820 = lerp( temp_output_3_0_g79820 , temp_output_17_0_g79820 , temp_output_19_0_g79820);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79820 = lerpResult22_g79820;
				#else
				float4 staticSwitch24_g79820 = ifLocalVar18_g79820;
				#endif
				half4 Global_Extras_Params5440_g79798 = staticSwitch24_g79820;
				float4 break456_g79805 = Global_Extras_Params5440_g79798;
				half Global_Extras_Overlay156_g79798 = break456_g79805.z;
				half Overlay_Value5738_g79798 = ( _GlobalOverlay * Global_Extras_Overlay156_g79798 );
				float3 ase_worldBitangent = packedInput.ase_texcoord9.xyz;
				float3x3 ase_worldToTangent = float3x3(tangentWS.xyz,ase_worldBitangent,normalWS);
				half4 Weights52_g83247 = Terrain_Weights_046781_g83242;
				TEXTURE2D(Texture238_g83295) = _NormalTex1;
				SamplerState Sampler238_g83295 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83295 = Input_Coords_016785_g83242;
				half4 Coords238_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition238_g83295 = ase_worldPos;
				half4 localSamplePlanar2D238_g83295 = SamplePlanar2D( Texture238_g83295 , Sampler238_g83295 , Coords238_g83295 , WorldPosition238_g83295 );
				TEXTURE2D(Texture246_g83295) = _NormalTex1;
				SamplerState Sampler246_g83295 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition246_g83295 = ase_worldPos;
				half3 WorldNormal246_g83295 = normalWS;
				half4 localSamplePlanar3D246_g83295 = SamplePlanar3D( Texture246_g83295 , Sampler246_g83295 , Coords246_g83295 , WorldPosition246_g83295 , WorldNormal246_g83295 );
				TEXTURE2D(Texture234_g83295) = _NormalTex1;
				SamplerState Sampler234_g83295 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83295 = temp_output_37_0_g83295;
				float3 WorldPosition234_g83295 = ase_worldPos;
				float4 localSampleStochastic2D234_g83295 = SampleStochastic2D( Texture234_g83295 , Sampler234_g83295 , Coords234_g83295 , WorldPosition234_g83295 );
				TEXTURE2D(Texture263_g83295) = _NormalTex1;
				SamplerState Sampler263_g83295 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83295 = temp_output_37_0_g83295;
				half3 WorldPosition263_g83295 = ase_worldPos;
				half3 WorldNormal263_g83295 = normalWS;
				half4 localSampleStochastic3D263_g83295 = SampleStochastic3D( Texture263_g83295 , Sampler263_g83295 , Coords263_g83295 , WorldPosition263_g83295 , WorldNormal263_g83295 );
				#if defined(TVE_SAMPLE_01_PLANAR_2D)
				float4 staticSwitch8635_g83242 = localSamplePlanar2D238_g83295;
				#elif defined(TVE_SAMPLE_01_PLANAR_3D)
				float4 staticSwitch8635_g83242 = localSamplePlanar3D246_g83295;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_2D)
				float4 staticSwitch8635_g83242 = localSampleStochastic2D234_g83295;
				#elif defined(TVE_SAMPLE_01_STOCHASTIC_3D)
				float4 staticSwitch8635_g83242 = localSampleStochastic3D263_g83295;
				#else
				float4 staticSwitch8635_g83242 = localSamplePlanar2D238_g83295;
				#endif
				half4 Layer133_g83247 = staticSwitch8635_g83242;
				TEXTURE2D(Texture238_g83296) = _NormalTex2;
				SamplerState Sampler238_g83296 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83296 = Input_Coords_026787_g83242;
				half4 Coords238_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition238_g83296 = ase_worldPos;
				half4 localSamplePlanar2D238_g83296 = SamplePlanar2D( Texture238_g83296 , Sampler238_g83296 , Coords238_g83296 , WorldPosition238_g83296 );
				TEXTURE2D(Texture246_g83296) = _NormalTex2;
				SamplerState Sampler246_g83296 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition246_g83296 = ase_worldPos;
				half3 WorldNormal246_g83296 = normalWS;
				half4 localSamplePlanar3D246_g83296 = SamplePlanar3D( Texture246_g83296 , Sampler246_g83296 , Coords246_g83296 , WorldPosition246_g83296 , WorldNormal246_g83296 );
				TEXTURE2D(Texture234_g83296) = _NormalTex2;
				SamplerState Sampler234_g83296 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83296 = temp_output_37_0_g83296;
				float3 WorldPosition234_g83296 = ase_worldPos;
				float4 localSampleStochastic2D234_g83296 = SampleStochastic2D( Texture234_g83296 , Sampler234_g83296 , Coords234_g83296 , WorldPosition234_g83296 );
				TEXTURE2D(Texture263_g83296) = _NormalTex2;
				SamplerState Sampler263_g83296 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83296 = temp_output_37_0_g83296;
				half3 WorldPosition263_g83296 = ase_worldPos;
				half3 WorldNormal263_g83296 = normalWS;
				half4 localSampleStochastic3D263_g83296 = SampleStochastic3D( Texture263_g83296 , Sampler263_g83296 , Coords263_g83296 , WorldPosition263_g83296 , WorldNormal263_g83296 );
				#if defined(TVE_SAMPLE_02_PLANAR_2D)
				float4 staticSwitch8636_g83242 = localSamplePlanar2D238_g83296;
				#elif defined(TVE_SAMPLE_02_PLANAR_3D)
				float4 staticSwitch8636_g83242 = localSamplePlanar3D246_g83296;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_2D)
				float4 staticSwitch8636_g83242 = localSampleStochastic2D234_g83296;
				#elif defined(TVE_SAMPLE_02_STOCHASTIC_3D)
				float4 staticSwitch8636_g83242 = localSampleStochastic3D263_g83296;
				#else
				float4 staticSwitch8636_g83242 = localSamplePlanar2D238_g83296;
				#endif
				half4 Layer237_g83247 = staticSwitch8636_g83242;
				TEXTURE2D(Texture238_g83297) = _NormalTex3;
				SamplerState Sampler238_g83297 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83297 = Input_Coords_036789_g83242;
				half4 Coords238_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition238_g83297 = ase_worldPos;
				half4 localSamplePlanar2D238_g83297 = SamplePlanar2D( Texture238_g83297 , Sampler238_g83297 , Coords238_g83297 , WorldPosition238_g83297 );
				TEXTURE2D(Texture246_g83297) = _NormalTex3;
				SamplerState Sampler246_g83297 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition246_g83297 = ase_worldPos;
				half3 WorldNormal246_g83297 = normalWS;
				half4 localSamplePlanar3D246_g83297 = SamplePlanar3D( Texture246_g83297 , Sampler246_g83297 , Coords246_g83297 , WorldPosition246_g83297 , WorldNormal246_g83297 );
				TEXTURE2D(Texture234_g83297) = _NormalTex3;
				SamplerState Sampler234_g83297 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83297 = temp_output_37_0_g83297;
				float3 WorldPosition234_g83297 = ase_worldPos;
				float4 localSampleStochastic2D234_g83297 = SampleStochastic2D( Texture234_g83297 , Sampler234_g83297 , Coords234_g83297 , WorldPosition234_g83297 );
				TEXTURE2D(Texture263_g83297) = _NormalTex3;
				SamplerState Sampler263_g83297 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83297 = temp_output_37_0_g83297;
				half3 WorldPosition263_g83297 = ase_worldPos;
				half3 WorldNormal263_g83297 = normalWS;
				half4 localSampleStochastic3D263_g83297 = SampleStochastic3D( Texture263_g83297 , Sampler263_g83297 , Coords263_g83297 , WorldPosition263_g83297 , WorldNormal263_g83297 );
				#if defined(TVE_SAMPLE_03_PLANAR_2D)
				float4 staticSwitch8637_g83242 = localSamplePlanar2D238_g83297;
				#elif defined(TVE_SAMPLE_03_PLANAR_3D)
				float4 staticSwitch8637_g83242 = localSamplePlanar3D246_g83297;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_2D)
				float4 staticSwitch8637_g83242 = localSampleStochastic2D234_g83297;
				#elif defined(TVE_SAMPLE_03_STOCHASTIC_3D)
				float4 staticSwitch8637_g83242 = localSampleStochastic3D263_g83297;
				#else
				float4 staticSwitch8637_g83242 = localSamplePlanar2D238_g83297;
				#endif
				half4 Layer338_g83247 = staticSwitch8637_g83242;
				TEXTURE2D(Texture238_g83298) = _NormalTex4;
				SamplerState Sampler238_g83298 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83298 = Input_Coords_046791_g83242;
				half4 Coords238_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition238_g83298 = ase_worldPos;
				half4 localSamplePlanar2D238_g83298 = SamplePlanar2D( Texture238_g83298 , Sampler238_g83298 , Coords238_g83298 , WorldPosition238_g83298 );
				TEXTURE2D(Texture246_g83298) = _NormalTex4;
				SamplerState Sampler246_g83298 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition246_g83298 = ase_worldPos;
				half3 WorldNormal246_g83298 = normalWS;
				half4 localSamplePlanar3D246_g83298 = SamplePlanar3D( Texture246_g83298 , Sampler246_g83298 , Coords246_g83298 , WorldPosition246_g83298 , WorldNormal246_g83298 );
				TEXTURE2D(Texture234_g83298) = _NormalTex4;
				SamplerState Sampler234_g83298 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83298 = temp_output_37_0_g83298;
				float3 WorldPosition234_g83298 = ase_worldPos;
				float4 localSampleStochastic2D234_g83298 = SampleStochastic2D( Texture234_g83298 , Sampler234_g83298 , Coords234_g83298 , WorldPosition234_g83298 );
				TEXTURE2D(Texture263_g83298) = _NormalTex4;
				SamplerState Sampler263_g83298 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83298 = temp_output_37_0_g83298;
				half3 WorldPosition263_g83298 = ase_worldPos;
				half3 WorldNormal263_g83298 = normalWS;
				half4 localSampleStochastic3D263_g83298 = SampleStochastic3D( Texture263_g83298 , Sampler263_g83298 , Coords263_g83298 , WorldPosition263_g83298 , WorldNormal263_g83298 );
				#if defined(TVE_SAMPLE_04_PLANAR_2D)
				float4 staticSwitch8638_g83242 = localSamplePlanar2D238_g83298;
				#elif defined(TVE_SAMPLE_04_PLANAR_3D)
				float4 staticSwitch8638_g83242 = localSamplePlanar3D246_g83298;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_2D)
				float4 staticSwitch8638_g83242 = localSampleStochastic2D234_g83298;
				#elif defined(TVE_SAMPLE_04_STOCHASTIC_3D)
				float4 staticSwitch8638_g83242 = localSampleStochastic3D263_g83298;
				#else
				float4 staticSwitch8638_g83242 = localSamplePlanar2D238_g83298;
				#endif
				half4 Layer439_g83247 = staticSwitch8638_g83242;
				float4 weightedBlendVar31_g83247 = Weights52_g83247;
				float4 weightedBlend31_g83247 = ( weightedBlendVar31_g83247.x*Layer133_g83247 + weightedBlendVar31_g83247.y*Layer237_g83247 + weightedBlendVar31_g83247.z*Layer338_g83247 + weightedBlendVar31_g83247.w*Layer439_g83247 );
				half4 Terrain_Normal_047202_g83242 = weightedBlend31_g83247;
				half4 Layer_045_g83257 = Terrain_Normal_047202_g83242;
				half4 Weights52_g83263 = Terrain_Weights_087340_g83242;
				TEXTURE2D(Texture238_g83307) = _NormalTex5;
				SamplerState Sampler238_g83307 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83307 = Input_Coords_058750_g83242;
				half4 Coords238_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition238_g83307 = ase_worldPos;
				half4 localSamplePlanar2D238_g83307 = SamplePlanar2D( Texture238_g83307 , Sampler238_g83307 , Coords238_g83307 , WorldPosition238_g83307 );
				TEXTURE2D(Texture246_g83307) = _NormalTex5;
				SamplerState Sampler246_g83307 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition246_g83307 = ase_worldPos;
				half3 WorldNormal246_g83307 = normalWS;
				half4 localSamplePlanar3D246_g83307 = SamplePlanar3D( Texture246_g83307 , Sampler246_g83307 , Coords246_g83307 , WorldPosition246_g83307 , WorldNormal246_g83307 );
				TEXTURE2D(Texture234_g83307) = _NormalTex5;
				SamplerState Sampler234_g83307 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83307 = temp_output_37_0_g83307;
				float3 WorldPosition234_g83307 = ase_worldPos;
				float4 localSampleStochastic2D234_g83307 = SampleStochastic2D( Texture234_g83307 , Sampler234_g83307 , Coords234_g83307 , WorldPosition234_g83307 );
				TEXTURE2D(Texture263_g83307) = _NormalTex5;
				SamplerState Sampler263_g83307 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83307 = temp_output_37_0_g83307;
				half3 WorldPosition263_g83307 = ase_worldPos;
				half3 WorldNormal263_g83307 = normalWS;
				half4 localSampleStochastic3D263_g83307 = SampleStochastic3D( Texture263_g83307 , Sampler263_g83307 , Coords263_g83307 , WorldPosition263_g83307 , WorldNormal263_g83307 );
				#if defined(TVE_SAMPLE_05_PLANAR_2D)
				float4 staticSwitch8686_g83242 = localSamplePlanar2D238_g83307;
				#elif defined(TVE_SAMPLE_05_PLANAR_3D)
				float4 staticSwitch8686_g83242 = localSamplePlanar3D246_g83307;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_2D)
				float4 staticSwitch8686_g83242 = localSampleStochastic2D234_g83307;
				#elif defined(TVE_SAMPLE_05_STOCHASTIC_3D)
				float4 staticSwitch8686_g83242 = localSampleStochastic3D263_g83307;
				#else
				float4 staticSwitch8686_g83242 = localSamplePlanar2D238_g83307;
				#endif
				half4 Layer133_g83263 = staticSwitch8686_g83242;
				TEXTURE2D(Texture238_g83308) = _NormalTex6;
				SamplerState Sampler238_g83308 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83308 = Input_Coords_068751_g83242;
				half4 Coords238_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition238_g83308 = ase_worldPos;
				half4 localSamplePlanar2D238_g83308 = SamplePlanar2D( Texture238_g83308 , Sampler238_g83308 , Coords238_g83308 , WorldPosition238_g83308 );
				TEXTURE2D(Texture246_g83308) = _NormalTex6;
				SamplerState Sampler246_g83308 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition246_g83308 = ase_worldPos;
				half3 WorldNormal246_g83308 = normalWS;
				half4 localSamplePlanar3D246_g83308 = SamplePlanar3D( Texture246_g83308 , Sampler246_g83308 , Coords246_g83308 , WorldPosition246_g83308 , WorldNormal246_g83308 );
				TEXTURE2D(Texture234_g83308) = _NormalTex6;
				SamplerState Sampler234_g83308 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83308 = temp_output_37_0_g83308;
				float3 WorldPosition234_g83308 = ase_worldPos;
				float4 localSampleStochastic2D234_g83308 = SampleStochastic2D( Texture234_g83308 , Sampler234_g83308 , Coords234_g83308 , WorldPosition234_g83308 );
				TEXTURE2D(Texture263_g83308) = _NormalTex6;
				SamplerState Sampler263_g83308 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83308 = temp_output_37_0_g83308;
				half3 WorldPosition263_g83308 = ase_worldPos;
				half3 WorldNormal263_g83308 = normalWS;
				half4 localSampleStochastic3D263_g83308 = SampleStochastic3D( Texture263_g83308 , Sampler263_g83308 , Coords263_g83308 , WorldPosition263_g83308 , WorldNormal263_g83308 );
				#if defined(TVE_SAMPLE_06_PLANAR_2D)
				float4 staticSwitch8687_g83242 = localSamplePlanar2D238_g83308;
				#elif defined(TVE_SAMPLE_06_PLANAR_3D)
				float4 staticSwitch8687_g83242 = localSamplePlanar3D246_g83308;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_2D)
				float4 staticSwitch8687_g83242 = localSampleStochastic2D234_g83308;
				#elif defined(TVE_SAMPLE_06_STOCHASTIC_3D)
				float4 staticSwitch8687_g83242 = localSampleStochastic3D263_g83308;
				#else
				float4 staticSwitch8687_g83242 = localSamplePlanar2D238_g83308;
				#endif
				half4 Layer237_g83263 = staticSwitch8687_g83242;
				TEXTURE2D(Texture238_g83309) = _NormalTex7;
				SamplerState Sampler238_g83309 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83309 = Input_Coords_078752_g83242;
				half4 Coords238_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition238_g83309 = ase_worldPos;
				half4 localSamplePlanar2D238_g83309 = SamplePlanar2D( Texture238_g83309 , Sampler238_g83309 , Coords238_g83309 , WorldPosition238_g83309 );
				TEXTURE2D(Texture246_g83309) = _NormalTex7;
				SamplerState Sampler246_g83309 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition246_g83309 = ase_worldPos;
				half3 WorldNormal246_g83309 = normalWS;
				half4 localSamplePlanar3D246_g83309 = SamplePlanar3D( Texture246_g83309 , Sampler246_g83309 , Coords246_g83309 , WorldPosition246_g83309 , WorldNormal246_g83309 );
				TEXTURE2D(Texture234_g83309) = _NormalTex7;
				SamplerState Sampler234_g83309 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83309 = temp_output_37_0_g83309;
				float3 WorldPosition234_g83309 = ase_worldPos;
				float4 localSampleStochastic2D234_g83309 = SampleStochastic2D( Texture234_g83309 , Sampler234_g83309 , Coords234_g83309 , WorldPosition234_g83309 );
				TEXTURE2D(Texture263_g83309) = _NormalTex7;
				SamplerState Sampler263_g83309 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83309 = temp_output_37_0_g83309;
				half3 WorldPosition263_g83309 = ase_worldPos;
				half3 WorldNormal263_g83309 = normalWS;
				half4 localSampleStochastic3D263_g83309 = SampleStochastic3D( Texture263_g83309 , Sampler263_g83309 , Coords263_g83309 , WorldPosition263_g83309 , WorldNormal263_g83309 );
				#if defined(TVE_SAMPLE_07_PLANAR_2D)
				float4 staticSwitch8688_g83242 = localSamplePlanar2D238_g83309;
				#elif defined(TVE_SAMPLE_07_PLANAR_3D)
				float4 staticSwitch8688_g83242 = localSamplePlanar3D246_g83309;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_2D)
				float4 staticSwitch8688_g83242 = localSampleStochastic2D234_g83309;
				#elif defined(TVE_SAMPLE_07_STOCHASTIC_3D)
				float4 staticSwitch8688_g83242 = localSampleStochastic3D263_g83309;
				#else
				float4 staticSwitch8688_g83242 = localSamplePlanar2D238_g83309;
				#endif
				half4 Layer338_g83263 = staticSwitch8688_g83242;
				TEXTURE2D(Texture238_g83310) = _NormalTex8;
				SamplerState Sampler238_g83310 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83310 = Input_Coords_088749_g83242;
				half4 Coords238_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition238_g83310 = ase_worldPos;
				half4 localSamplePlanar2D238_g83310 = SamplePlanar2D( Texture238_g83310 , Sampler238_g83310 , Coords238_g83310 , WorldPosition238_g83310 );
				TEXTURE2D(Texture246_g83310) = _NormalTex8;
				SamplerState Sampler246_g83310 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition246_g83310 = ase_worldPos;
				half3 WorldNormal246_g83310 = normalWS;
				half4 localSamplePlanar3D246_g83310 = SamplePlanar3D( Texture246_g83310 , Sampler246_g83310 , Coords246_g83310 , WorldPosition246_g83310 , WorldNormal246_g83310 );
				TEXTURE2D(Texture234_g83310) = _NormalTex8;
				SamplerState Sampler234_g83310 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83310 = temp_output_37_0_g83310;
				float3 WorldPosition234_g83310 = ase_worldPos;
				float4 localSampleStochastic2D234_g83310 = SampleStochastic2D( Texture234_g83310 , Sampler234_g83310 , Coords234_g83310 , WorldPosition234_g83310 );
				TEXTURE2D(Texture263_g83310) = _NormalTex8;
				SamplerState Sampler263_g83310 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83310 = temp_output_37_0_g83310;
				half3 WorldPosition263_g83310 = ase_worldPos;
				half3 WorldNormal263_g83310 = normalWS;
				half4 localSampleStochastic3D263_g83310 = SampleStochastic3D( Texture263_g83310 , Sampler263_g83310 , Coords263_g83310 , WorldPosition263_g83310 , WorldNormal263_g83310 );
				#if defined(TVE_SAMPLE_08_PLANAR_2D)
				float4 staticSwitch8689_g83242 = localSamplePlanar2D238_g83310;
				#elif defined(TVE_SAMPLE_08_PLANAR_3D)
				float4 staticSwitch8689_g83242 = localSamplePlanar3D246_g83310;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_2D)
				float4 staticSwitch8689_g83242 = localSampleStochastic2D234_g83310;
				#elif defined(TVE_SAMPLE_08_STOCHASTIC_3D)
				float4 staticSwitch8689_g83242 = localSampleStochastic3D263_g83310;
				#else
				float4 staticSwitch8689_g83242 = localSamplePlanar2D238_g83310;
				#endif
				half4 Layer439_g83263 = staticSwitch8689_g83242;
				float4 weightedBlendVar31_g83263 = Weights52_g83263;
				float4 weightedBlend31_g83263 = ( weightedBlendVar31_g83263.x*Layer133_g83263 + weightedBlendVar31_g83263.y*Layer237_g83263 + weightedBlendVar31_g83263.z*Layer338_g83263 + weightedBlendVar31_g83263.w*Layer439_g83263 );
				half4 Terrain_Normal_088684_g83242 = weightedBlend31_g83263;
				half4 Layer_0810_g83257 = Terrain_Normal_088684_g83242;
				half4 Weights52_g83273 = Terrain_Weights_127710_g83242;
				TEXTURE2D(Texture238_g83319) = _NormalTex9;
				SamplerState Sampler238_g83319 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83319 = Input_Coords_098833_g83242;
				half4 Coords238_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition238_g83319 = ase_worldPos;
				half4 localSamplePlanar2D238_g83319 = SamplePlanar2D( Texture238_g83319 , Sampler238_g83319 , Coords238_g83319 , WorldPosition238_g83319 );
				TEXTURE2D(Texture246_g83319) = _NormalTex9;
				SamplerState Sampler246_g83319 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition246_g83319 = ase_worldPos;
				half3 WorldNormal246_g83319 = normalWS;
				half4 localSamplePlanar3D246_g83319 = SamplePlanar3D( Texture246_g83319 , Sampler246_g83319 , Coords246_g83319 , WorldPosition246_g83319 , WorldNormal246_g83319 );
				TEXTURE2D(Texture234_g83319) = _NormalTex9;
				SamplerState Sampler234_g83319 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83319 = temp_output_37_0_g83319;
				float3 WorldPosition234_g83319 = ase_worldPos;
				float4 localSampleStochastic2D234_g83319 = SampleStochastic2D( Texture234_g83319 , Sampler234_g83319 , Coords234_g83319 , WorldPosition234_g83319 );
				TEXTURE2D(Texture263_g83319) = _NormalTex9;
				SamplerState Sampler263_g83319 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83319 = temp_output_37_0_g83319;
				half3 WorldPosition263_g83319 = ase_worldPos;
				half3 WorldNormal263_g83319 = normalWS;
				half4 localSampleStochastic3D263_g83319 = SampleStochastic3D( Texture263_g83319 , Sampler263_g83319 , Coords263_g83319 , WorldPosition263_g83319 , WorldNormal263_g83319 );
				#if defined(TVE_SAMPLE_09_PLANAR_2D)
				float4 staticSwitch8849_g83242 = localSamplePlanar2D238_g83319;
				#elif defined(TVE_SAMPLE_09_PLANAR_3D)
				float4 staticSwitch8849_g83242 = localSamplePlanar3D246_g83319;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_2D)
				float4 staticSwitch8849_g83242 = localSampleStochastic2D234_g83319;
				#elif defined(TVE_SAMPLE_09_STOCHASTIC_3D)
				float4 staticSwitch8849_g83242 = localSampleStochastic3D263_g83319;
				#else
				float4 staticSwitch8849_g83242 = localSamplePlanar2D238_g83319;
				#endif
				half4 Layer133_g83273 = staticSwitch8849_g83242;
				TEXTURE2D(Texture238_g83320) = _NormalTex10;
				SamplerState Sampler238_g83320 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83320 = Input_Coords_108834_g83242;
				half4 Coords238_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition238_g83320 = ase_worldPos;
				half4 localSamplePlanar2D238_g83320 = SamplePlanar2D( Texture238_g83320 , Sampler238_g83320 , Coords238_g83320 , WorldPosition238_g83320 );
				TEXTURE2D(Texture246_g83320) = _NormalTex10;
				SamplerState Sampler246_g83320 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition246_g83320 = ase_worldPos;
				half3 WorldNormal246_g83320 = normalWS;
				half4 localSamplePlanar3D246_g83320 = SamplePlanar3D( Texture246_g83320 , Sampler246_g83320 , Coords246_g83320 , WorldPosition246_g83320 , WorldNormal246_g83320 );
				TEXTURE2D(Texture234_g83320) = _NormalTex10;
				SamplerState Sampler234_g83320 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83320 = temp_output_37_0_g83320;
				float3 WorldPosition234_g83320 = ase_worldPos;
				float4 localSampleStochastic2D234_g83320 = SampleStochastic2D( Texture234_g83320 , Sampler234_g83320 , Coords234_g83320 , WorldPosition234_g83320 );
				TEXTURE2D(Texture263_g83320) = _NormalTex10;
				SamplerState Sampler263_g83320 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83320 = temp_output_37_0_g83320;
				half3 WorldPosition263_g83320 = ase_worldPos;
				half3 WorldNormal263_g83320 = normalWS;
				half4 localSampleStochastic3D263_g83320 = SampleStochastic3D( Texture263_g83320 , Sampler263_g83320 , Coords263_g83320 , WorldPosition263_g83320 , WorldNormal263_g83320 );
				#if defined(TVE_SAMPLE_10_PLANAR_2D)
				float4 staticSwitch8876_g83242 = localSamplePlanar2D238_g83320;
				#elif defined(TVE_SAMPLE_10_PLANAR_3D)
				float4 staticSwitch8876_g83242 = localSamplePlanar3D246_g83320;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_2D)
				float4 staticSwitch8876_g83242 = localSampleStochastic2D234_g83320;
				#elif defined(TVE_SAMPLE_10_STOCHASTIC_3D)
				float4 staticSwitch8876_g83242 = localSampleStochastic3D263_g83320;
				#else
				float4 staticSwitch8876_g83242 = localSamplePlanar2D238_g83320;
				#endif
				half4 Layer237_g83273 = staticSwitch8876_g83242;
				TEXTURE2D(Texture238_g83321) = _NormalTex11;
				SamplerState Sampler238_g83321 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83321 = Input_Coords_118835_g83242;
				half4 Coords238_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition238_g83321 = ase_worldPos;
				half4 localSamplePlanar2D238_g83321 = SamplePlanar2D( Texture238_g83321 , Sampler238_g83321 , Coords238_g83321 , WorldPosition238_g83321 );
				TEXTURE2D(Texture246_g83321) = _NormalTex11;
				SamplerState Sampler246_g83321 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition246_g83321 = ase_worldPos;
				half3 WorldNormal246_g83321 = normalWS;
				half4 localSamplePlanar3D246_g83321 = SamplePlanar3D( Texture246_g83321 , Sampler246_g83321 , Coords246_g83321 , WorldPosition246_g83321 , WorldNormal246_g83321 );
				TEXTURE2D(Texture234_g83321) = _NormalTex11;
				SamplerState Sampler234_g83321 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83321 = temp_output_37_0_g83321;
				float3 WorldPosition234_g83321 = ase_worldPos;
				float4 localSampleStochastic2D234_g83321 = SampleStochastic2D( Texture234_g83321 , Sampler234_g83321 , Coords234_g83321 , WorldPosition234_g83321 );
				TEXTURE2D(Texture263_g83321) = _NormalTex11;
				SamplerState Sampler263_g83321 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83321 = temp_output_37_0_g83321;
				half3 WorldPosition263_g83321 = ase_worldPos;
				half3 WorldNormal263_g83321 = normalWS;
				half4 localSampleStochastic3D263_g83321 = SampleStochastic3D( Texture263_g83321 , Sampler263_g83321 , Coords263_g83321 , WorldPosition263_g83321 , WorldNormal263_g83321 );
				#if defined(TVE_SAMPLE_11_PLANAR_2D)
				float4 staticSwitch8850_g83242 = localSamplePlanar2D238_g83321;
				#elif defined(TVE_SAMPLE_11_PLANAR_3D)
				float4 staticSwitch8850_g83242 = localSamplePlanar3D246_g83321;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_2D)
				float4 staticSwitch8850_g83242 = localSampleStochastic2D234_g83321;
				#elif defined(TVE_SAMPLE_11_STOCHASTIC_3D)
				float4 staticSwitch8850_g83242 = localSampleStochastic3D263_g83321;
				#else
				float4 staticSwitch8850_g83242 = localSamplePlanar2D238_g83321;
				#endif
				half4 Layer338_g83273 = staticSwitch8850_g83242;
				TEXTURE2D(Texture238_g83322) = _NormalTex12;
				SamplerState Sampler238_g83322 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83322 = Input_Coords_128836_g83242;
				half4 Coords238_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition238_g83322 = ase_worldPos;
				half4 localSamplePlanar2D238_g83322 = SamplePlanar2D( Texture238_g83322 , Sampler238_g83322 , Coords238_g83322 , WorldPosition238_g83322 );
				TEXTURE2D(Texture246_g83322) = _NormalTex12;
				SamplerState Sampler246_g83322 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition246_g83322 = ase_worldPos;
				half3 WorldNormal246_g83322 = normalWS;
				half4 localSamplePlanar3D246_g83322 = SamplePlanar3D( Texture246_g83322 , Sampler246_g83322 , Coords246_g83322 , WorldPosition246_g83322 , WorldNormal246_g83322 );
				TEXTURE2D(Texture234_g83322) = _NormalTex12;
				SamplerState Sampler234_g83322 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83322 = temp_output_37_0_g83322;
				float3 WorldPosition234_g83322 = ase_worldPos;
				float4 localSampleStochastic2D234_g83322 = SampleStochastic2D( Texture234_g83322 , Sampler234_g83322 , Coords234_g83322 , WorldPosition234_g83322 );
				TEXTURE2D(Texture263_g83322) = _NormalTex12;
				SamplerState Sampler263_g83322 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83322 = temp_output_37_0_g83322;
				half3 WorldPosition263_g83322 = ase_worldPos;
				half3 WorldNormal263_g83322 = normalWS;
				half4 localSampleStochastic3D263_g83322 = SampleStochastic3D( Texture263_g83322 , Sampler263_g83322 , Coords263_g83322 , WorldPosition263_g83322 , WorldNormal263_g83322 );
				#if defined(TVE_SAMPLE_12_PLANAR_2D)
				float4 staticSwitch8877_g83242 = localSamplePlanar2D238_g83322;
				#elif defined(TVE_SAMPLE_12_PLANAR_3D)
				float4 staticSwitch8877_g83242 = localSamplePlanar3D246_g83322;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_2D)
				float4 staticSwitch8877_g83242 = localSampleStochastic2D234_g83322;
				#elif defined(TVE_SAMPLE_12_STOCHASTIC_3D)
				float4 staticSwitch8877_g83242 = localSampleStochastic3D263_g83322;
				#else
				float4 staticSwitch8877_g83242 = localSamplePlanar2D238_g83322;
				#endif
				half4 Layer439_g83273 = staticSwitch8877_g83242;
				float4 weightedBlendVar31_g83273 = Weights52_g83273;
				float4 weightedBlend31_g83273 = ( weightedBlendVar31_g83273.x*Layer133_g83273 + weightedBlendVar31_g83273.y*Layer237_g83273 + weightedBlendVar31_g83273.z*Layer338_g83273 + weightedBlendVar31_g83273.w*Layer439_g83273 );
				half4 Terrain_Normal_128865_g83242 = weightedBlend31_g83273;
				half4 Layer_1243_g83257 = Terrain_Normal_128865_g83242;
				half4 Weights52_g83283 = Terrain_Weights_167709_g83242;
				TEXTURE2D(Texture238_g83338) = _NormalTex13;
				SamplerState Sampler238_g83338 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83338 = Input_Coords_138960_g83242;
				half4 Coords238_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition238_g83338 = ase_worldPos;
				half4 localSamplePlanar2D238_g83338 = SamplePlanar2D( Texture238_g83338 , Sampler238_g83338 , Coords238_g83338 , WorldPosition238_g83338 );
				TEXTURE2D(Texture246_g83338) = _NormalTex13;
				SamplerState Sampler246_g83338 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition246_g83338 = ase_worldPos;
				half3 WorldNormal246_g83338 = normalWS;
				half4 localSamplePlanar3D246_g83338 = SamplePlanar3D( Texture246_g83338 , Sampler246_g83338 , Coords246_g83338 , WorldPosition246_g83338 , WorldNormal246_g83338 );
				TEXTURE2D(Texture234_g83338) = _NormalTex13;
				SamplerState Sampler234_g83338 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83338 = temp_output_37_0_g83338;
				float3 WorldPosition234_g83338 = ase_worldPos;
				float4 localSampleStochastic2D234_g83338 = SampleStochastic2D( Texture234_g83338 , Sampler234_g83338 , Coords234_g83338 , WorldPosition234_g83338 );
				TEXTURE2D(Texture263_g83338) = _NormalTex13;
				SamplerState Sampler263_g83338 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83338 = temp_output_37_0_g83338;
				half3 WorldPosition263_g83338 = ase_worldPos;
				half3 WorldNormal263_g83338 = normalWS;
				half4 localSampleStochastic3D263_g83338 = SampleStochastic3D( Texture263_g83338 , Sampler263_g83338 , Coords263_g83338 , WorldPosition263_g83338 , WorldNormal263_g83338 );
				#if defined(TVE_SAMPLE_13_PLANAR_2D)
				float4 staticSwitch8991_g83242 = localSamplePlanar2D238_g83338;
				#elif defined(TVE_SAMPLE_13_PLANAR_3D)
				float4 staticSwitch8991_g83242 = localSamplePlanar3D246_g83338;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_2D)
				float4 staticSwitch8991_g83242 = localSampleStochastic2D234_g83338;
				#elif defined(TVE_SAMPLE_13_STOCHASTIC_3D)
				float4 staticSwitch8991_g83242 = localSampleStochastic3D263_g83338;
				#else
				float4 staticSwitch8991_g83242 = localSamplePlanar2D238_g83338;
				#endif
				half4 Layer133_g83283 = staticSwitch8991_g83242;
				TEXTURE2D(Texture238_g83331) = _NormalTex14;
				SamplerState Sampler238_g83331 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83331 = Input_Coords_148961_g83242;
				half4 Coords238_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition238_g83331 = ase_worldPos;
				half4 localSamplePlanar2D238_g83331 = SamplePlanar2D( Texture238_g83331 , Sampler238_g83331 , Coords238_g83331 , WorldPosition238_g83331 );
				TEXTURE2D(Texture246_g83331) = _NormalTex14;
				SamplerState Sampler246_g83331 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition246_g83331 = ase_worldPos;
				half3 WorldNormal246_g83331 = normalWS;
				half4 localSamplePlanar3D246_g83331 = SamplePlanar3D( Texture246_g83331 , Sampler246_g83331 , Coords246_g83331 , WorldPosition246_g83331 , WorldNormal246_g83331 );
				TEXTURE2D(Texture234_g83331) = _NormalTex14;
				SamplerState Sampler234_g83331 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83331 = temp_output_37_0_g83331;
				float3 WorldPosition234_g83331 = ase_worldPos;
				float4 localSampleStochastic2D234_g83331 = SampleStochastic2D( Texture234_g83331 , Sampler234_g83331 , Coords234_g83331 , WorldPosition234_g83331 );
				TEXTURE2D(Texture263_g83331) = _NormalTex14;
				SamplerState Sampler263_g83331 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83331 = temp_output_37_0_g83331;
				half3 WorldPosition263_g83331 = ase_worldPos;
				half3 WorldNormal263_g83331 = normalWS;
				half4 localSampleStochastic3D263_g83331 = SampleStochastic3D( Texture263_g83331 , Sampler263_g83331 , Coords263_g83331 , WorldPosition263_g83331 , WorldNormal263_g83331 );
				#if defined(TVE_SAMPLE_14_PLANAR_2D)
				float4 staticSwitch8990_g83242 = localSamplePlanar2D238_g83331;
				#elif defined(TVE_SAMPLE_14_PLANAR_3D)
				float4 staticSwitch8990_g83242 = localSamplePlanar3D246_g83331;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_2D)
				float4 staticSwitch8990_g83242 = localSampleStochastic2D234_g83331;
				#elif defined(TVE_SAMPLE_14_STOCHASTIC_3D)
				float4 staticSwitch8990_g83242 = localSampleStochastic3D263_g83331;
				#else
				float4 staticSwitch8990_g83242 = localSamplePlanar2D238_g83331;
				#endif
				half4 Layer237_g83283 = staticSwitch8990_g83242;
				TEXTURE2D(Texture238_g83332) = _NormalTex15;
				SamplerState Sampler238_g83332 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83332 = Input_Coords_158962_g83242;
				half4 Coords238_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition238_g83332 = ase_worldPos;
				half4 localSamplePlanar2D238_g83332 = SamplePlanar2D( Texture238_g83332 , Sampler238_g83332 , Coords238_g83332 , WorldPosition238_g83332 );
				TEXTURE2D(Texture246_g83332) = _NormalTex15;
				SamplerState Sampler246_g83332 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition246_g83332 = ase_worldPos;
				half3 WorldNormal246_g83332 = normalWS;
				half4 localSamplePlanar3D246_g83332 = SamplePlanar3D( Texture246_g83332 , Sampler246_g83332 , Coords246_g83332 , WorldPosition246_g83332 , WorldNormal246_g83332 );
				TEXTURE2D(Texture234_g83332) = _NormalTex15;
				SamplerState Sampler234_g83332 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83332 = temp_output_37_0_g83332;
				float3 WorldPosition234_g83332 = ase_worldPos;
				float4 localSampleStochastic2D234_g83332 = SampleStochastic2D( Texture234_g83332 , Sampler234_g83332 , Coords234_g83332 , WorldPosition234_g83332 );
				TEXTURE2D(Texture263_g83332) = _NormalTex15;
				SamplerState Sampler263_g83332 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83332 = temp_output_37_0_g83332;
				half3 WorldPosition263_g83332 = ase_worldPos;
				half3 WorldNormal263_g83332 = normalWS;
				half4 localSampleStochastic3D263_g83332 = SampleStochastic3D( Texture263_g83332 , Sampler263_g83332 , Coords263_g83332 , WorldPosition263_g83332 , WorldNormal263_g83332 );
				#if defined(TVE_SAMPLE_15_PLANAR_2D)
				float4 staticSwitch8989_g83242 = localSamplePlanar2D238_g83332;
				#elif defined(TVE_SAMPLE_15_PLANAR_3D)
				float4 staticSwitch8989_g83242 = localSamplePlanar3D246_g83332;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_2D)
				float4 staticSwitch8989_g83242 = localSampleStochastic2D234_g83332;
				#elif defined(TVE_SAMPLE_15_STOCHASTIC_3D)
				float4 staticSwitch8989_g83242 = localSampleStochastic3D263_g83332;
				#else
				float4 staticSwitch8989_g83242 = localSamplePlanar2D238_g83332;
				#endif
				half4 Layer338_g83283 = staticSwitch8989_g83242;
				TEXTURE2D(Texture238_g83333) = _NormalTex16;
				SamplerState Sampler238_g83333 = sampler_Linear_Repeat_Aniso8;
				float4 temp_output_37_0_g83333 = Input_Coords_168959_g83242;
				half4 Coords238_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition238_g83333 = ase_worldPos;
				half4 localSamplePlanar2D238_g83333 = SamplePlanar2D( Texture238_g83333 , Sampler238_g83333 , Coords238_g83333 , WorldPosition238_g83333 );
				TEXTURE2D(Texture246_g83333) = _NormalTex16;
				SamplerState Sampler246_g83333 = sampler_Linear_Repeat_Aniso8;
				half4 Coords246_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition246_g83333 = ase_worldPos;
				half3 WorldNormal246_g83333 = normalWS;
				half4 localSamplePlanar3D246_g83333 = SamplePlanar3D( Texture246_g83333 , Sampler246_g83333 , Coords246_g83333 , WorldPosition246_g83333 , WorldNormal246_g83333 );
				TEXTURE2D(Texture234_g83333) = _NormalTex16;
				SamplerState Sampler234_g83333 = sampler_Linear_Repeat_Aniso8;
				float4 Coords234_g83333 = temp_output_37_0_g83333;
				float3 WorldPosition234_g83333 = ase_worldPos;
				float4 localSampleStochastic2D234_g83333 = SampleStochastic2D( Texture234_g83333 , Sampler234_g83333 , Coords234_g83333 , WorldPosition234_g83333 );
				TEXTURE2D(Texture263_g83333) = _NormalTex16;
				SamplerState Sampler263_g83333 = sampler_Linear_Repeat_Aniso8;
				half4 Coords263_g83333 = temp_output_37_0_g83333;
				half3 WorldPosition263_g83333 = ase_worldPos;
				half3 WorldNormal263_g83333 = normalWS;
				half4 localSampleStochastic3D263_g83333 = SampleStochastic3D( Texture263_g83333 , Sampler263_g83333 , Coords263_g83333 , WorldPosition263_g83333 , WorldNormal263_g83333 );
				#if defined(TVE_SAMPLE_16_PLANAR_2D)
				float4 staticSwitch8988_g83242 = localSamplePlanar2D238_g83333;
				#elif defined(TVE_SAMPLE_16_PLANAR_3D)
				float4 staticSwitch8988_g83242 = localSamplePlanar3D246_g83333;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_2D)
				float4 staticSwitch8988_g83242 = localSampleStochastic2D234_g83333;
				#elif defined(TVE_SAMPLE_16_STOCHASTIC_3D)
				float4 staticSwitch8988_g83242 = localSampleStochastic3D263_g83333;
				#else
				float4 staticSwitch8988_g83242 = localSamplePlanar2D238_g83333;
				#endif
				half4 Layer439_g83283 = staticSwitch8988_g83242;
				float4 weightedBlendVar31_g83283 = Weights52_g83283;
				float4 weightedBlend31_g83283 = ( weightedBlendVar31_g83283.x*Layer133_g83283 + weightedBlendVar31_g83283.y*Layer237_g83283 + weightedBlendVar31_g83283.z*Layer338_g83283 + weightedBlendVar31_g83283.w*Layer439_g83283 );
				half4 Terrain_Normal_168987_g83242 = weightedBlend31_g83283;
				half4 Layer_1644_g83257 = Terrain_Normal_168987_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83257 = Layer_045_g83257;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 + Layer_1243_g83257 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83257 = ( Layer_045_g83257 + Layer_0810_g83257 + Layer_1243_g83257 + Layer_1644_g83257 );
				#else
				float4 staticSwitch40_g83257 = Layer_045_g83257;
				#endif
				half4 Blend_Normal7512_g83242 = staticSwitch40_g83257;
				half4 Normal_Packed45_g83244 = Blend_Normal7512_g83242;
				float2 appendResult58_g83244 = (float2(( (Normal_Packed45_g83244).x * (Normal_Packed45_g83244).w ) , (Normal_Packed45_g83244).y));
				half2 Normal_Default50_g83244 = appendResult58_g83244;
				half2 Normal_ASTC41_g83244 = (Normal_Packed45_g83244).xy;
				#ifdef UNITY_ASTC_NORMALMAP_ENCODING
				float2 staticSwitch38_g83244 = Normal_ASTC41_g83244;
				#else
				float2 staticSwitch38_g83244 = Normal_Default50_g83244;
				#endif
				half2 Normal_NO_DTX544_g83244 = (Normal_Packed45_g83244).wy;
				#ifdef UNITY_NO_DXT5nm
				float2 staticSwitch37_g83244 = Normal_NO_DTX544_g83244;
				#else
				float2 staticSwitch37_g83244 = staticSwitch38_g83244;
				#endif
				half4 Weights52_g83249 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83249 = temp_output_6970_0_g83242;
				half4 Layer237_g83249 = temp_output_6977_0_g83242;
				half4 Layer338_g83249 = temp_output_6978_0_g83242;
				half4 Layer439_g83249 = temp_output_6983_0_g83242;
				float4 weightedBlendVar31_g83249 = Weights52_g83249;
				float4 weightedBlend31_g83249 = ( weightedBlendVar31_g83249.x*Layer133_g83249 + weightedBlendVar31_g83249.y*Layer237_g83249 + weightedBlendVar31_g83249.z*Layer338_g83249 + weightedBlendVar31_g83249.w*Layer439_g83249 );
				half4 Terrain_Masks_047203_g83242 = weightedBlend31_g83249;
				half4 Layer_045_g83259 = Terrain_Masks_047203_g83242;
				half4 Weights52_g83266 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83266 = temp_output_8714_0_g83242;
				half4 Layer237_g83266 = temp_output_8721_0_g83242;
				half4 Layer338_g83266 = temp_output_8724_0_g83242;
				half4 Layer439_g83266 = temp_output_8727_0_g83242;
				float4 weightedBlendVar31_g83266 = Weights52_g83266;
				float4 weightedBlend31_g83266 = ( weightedBlendVar31_g83266.x*Layer133_g83266 + weightedBlendVar31_g83266.y*Layer237_g83266 + weightedBlendVar31_g83266.z*Layer338_g83266 + weightedBlendVar31_g83266.w*Layer439_g83266 );
				half4 Terrain_Masks_088730_g83242 = weightedBlend31_g83266;
				half4 Layer_0810_g83259 = Terrain_Masks_088730_g83242;
				half4 Weights52_g83276 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83276 = temp_output_8815_0_g83242;
				half4 Layer237_g83276 = temp_output_8818_0_g83242;
				half4 Layer338_g83276 = temp_output_8819_0_g83242;
				half4 Layer439_g83276 = temp_output_8820_0_g83242;
				float4 weightedBlendVar31_g83276 = Weights52_g83276;
				float4 weightedBlend31_g83276 = ( weightedBlendVar31_g83276.x*Layer133_g83276 + weightedBlendVar31_g83276.y*Layer237_g83276 + weightedBlendVar31_g83276.z*Layer338_g83276 + weightedBlendVar31_g83276.w*Layer439_g83276 );
				half4 Terrain_Masks_128871_g83242 = weightedBlend31_g83276;
				half4 Layer_1243_g83259 = Terrain_Masks_128871_g83242;
				half4 Weights52_g83286 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83286 = temp_output_8931_0_g83242;
				half4 Layer237_g83286 = temp_output_8934_0_g83242;
				half4 Layer338_g83286 = temp_output_8935_0_g83242;
				half4 Layer439_g83286 = temp_output_8936_0_g83242;
				float4 weightedBlendVar31_g83286 = Weights52_g83286;
				float4 weightedBlend31_g83286 = ( weightedBlendVar31_g83286.x*Layer133_g83286 + weightedBlendVar31_g83286.y*Layer237_g83286 + weightedBlendVar31_g83286.z*Layer338_g83286 + weightedBlendVar31_g83286.w*Layer439_g83286 );
				half4 Terrain_Masks_169014_g83242 = weightedBlend31_g83286;
				half4 Layer_1644_g83259 = Terrain_Masks_169014_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83259 = Layer_045_g83259;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 + Layer_1243_g83259 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83259 = ( Layer_045_g83259 + Layer_0810_g83259 + Layer_1243_g83259 + Layer_1644_g83259 );
				#else
				float4 staticSwitch40_g83259 = Layer_045_g83259;
				#endif
				half4 Blend_Masks7420_g83242 = staticSwitch40_g83259;
				half4 Normal_Packed45_g83243 = Blend_Masks7420_g83242;
				half2 Normal_NO_DTX544_g83243 = (Normal_Packed45_g83243).wy;
				#ifdef TVE_PACKED_TEX
				float2 staticSwitch8562_g83242 = (Normal_NO_DTX544_g83243*2.0 + -1.0);
				#else
				float2 staticSwitch8562_g83242 = (staticSwitch37_g83244*2.0 + -1.0);
				#endif
				half4 Weights52_g83253 = Terrain_Weights_046781_g83242;
				half4 Layer133_g83253 = _Params1;
				half4 Layer237_g83253 = _Params2;
				half4 Layer338_g83253 = _Params3;
				half4 Layer439_g83253 = _Params4;
				float4 weightedBlendVar31_g83253 = Weights52_g83253;
				float4 weightedBlend31_g83253 = ( weightedBlendVar31_g83253.x*Layer133_g83253 + weightedBlendVar31_g83253.y*Layer237_g83253 + weightedBlendVar31_g83253.z*Layer338_g83253 + weightedBlendVar31_g83253.w*Layer439_g83253 );
				half4 Terrain_Params_047533_g83242 = weightedBlend31_g83253;
				half4 Layer_045_g83260 = Terrain_Params_047533_g83242;
				half4 Weights52_g83270 = Terrain_Weights_087340_g83242;
				half4 Layer133_g83270 = _Params5;
				half4 Layer237_g83270 = _Params6;
				half4 Layer338_g83270 = _Params7;
				half4 Layer439_g83270 = _Params8;
				float4 weightedBlendVar31_g83270 = Weights52_g83270;
				float4 weightedBlend31_g83270 = ( weightedBlendVar31_g83270.x*Layer133_g83270 + weightedBlendVar31_g83270.y*Layer237_g83270 + weightedBlendVar31_g83270.z*Layer338_g83270 + weightedBlendVar31_g83270.w*Layer439_g83270 );
				half4 Terrain_Params_088739_g83242 = weightedBlend31_g83270;
				half4 Layer_0810_g83260 = Terrain_Params_088739_g83242;
				half4 Weights52_g83280 = Terrain_Weights_127710_g83242;
				half4 Layer133_g83280 = _Params9;
				half4 Layer237_g83280 = _Params10;
				half4 Layer338_g83280 = _Params11;
				half4 Layer439_g83280 = _Params12;
				float4 weightedBlendVar31_g83280 = Weights52_g83280;
				float4 weightedBlend31_g83280 = ( weightedBlendVar31_g83280.x*Layer133_g83280 + weightedBlendVar31_g83280.y*Layer237_g83280 + weightedBlendVar31_g83280.z*Layer338_g83280 + weightedBlendVar31_g83280.w*Layer439_g83280 );
				half4 Terrain_Params_128867_g83242 = weightedBlend31_g83280;
				half4 Layer_1243_g83260 = Terrain_Params_128867_g83242;
				half4 Weights52_g83290 = Terrain_Weights_167709_g83242;
				half4 Layer133_g83290 = _Params13;
				half4 Layer237_g83290 = _Params14;
				half4 Layer338_g83290 = _Params15;
				half4 Layer439_g83290 = _Params16;
				float4 weightedBlendVar31_g83290 = Weights52_g83290;
				float4 weightedBlend31_g83290 = ( weightedBlendVar31_g83290.x*Layer133_g83290 + weightedBlendVar31_g83290.y*Layer237_g83290 + weightedBlendVar31_g83290.z*Layer338_g83290 + weightedBlendVar31_g83290.w*Layer439_g83290 );
				half4 Terrain_Params_169017_g83242 = weightedBlend31_g83290;
				half4 Layer_1644_g83260 = Terrain_Params_169017_g83242;
				#if defined(TVE_TERRAIN_04)
				float4 staticSwitch40_g83260 = Layer_045_g83260;
				#elif defined(TVE_TERRAIN_08)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 );
				#elif defined(TVE_TERRAIN_12)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 + Layer_1243_g83260 );
				#elif defined(TVE_TERRAIN_16)
				float4 staticSwitch40_g83260 = ( Layer_045_g83260 + Layer_0810_g83260 + Layer_1243_g83260 + Layer_1644_g83260 );
				#else
				float4 staticSwitch40_g83260 = Layer_045_g83260;
				#endif
				half4 Blend_Params7547_g83242 = staticSwitch40_g83260;
				half2 Normal_Planar45_g83246 = ( staticSwitch8562_g83242 * (Blend_Params7547_g83242).z );
				float2 break64_g83246 = Normal_Planar45_g83246;
				float3 appendResult65_g83246 = (float3(break64_g83246.x , 0.0 , break64_g83246.y));
				half2 Terrain_Normal6871_g79798 = (mul( ase_worldToTangent, appendResult65_g83246 )).xy;
				float2 temp_output_7045_0_g79798 = ( Terrain_Normal6871_g79798 * _TerrainNormalValue );
				float3 appendResult7219_g79798 = (float3(temp_output_7045_0_g79798 , 1.0));
				float3 tanToWorld0 = float3( tangentWS.xyz.x, ase_worldBitangent.x, normalWS.x );
				float3 tanToWorld1 = float3( tangentWS.xyz.y, ase_worldBitangent.y, normalWS.y );
				float3 tanToWorld2 = float3( tangentWS.xyz.z, ase_worldBitangent.z, normalWS.z );
				float3 tanNormal7220_g79798 = appendResult7219_g79798;
				float3 worldNormal7220_g79798 = normalize( float3(dot(tanToWorld0,tanNormal7220_g79798), dot(tanToWorld1,tanNormal7220_g79798), dot(tanToWorld2,tanNormal7220_g79798)) );
				half3 Blend_Normal_WS7221_g79798 = worldNormal7220_g79798;
				float temp_output_7222_0_g79798 = (Blend_Normal_WS7221_g79798).y;
				float lerpResult6757_g79798 = lerp( 1.0 , saturate( temp_output_7222_0_g79798 ) , _OverlayProjectionValue);
				half Overlay_Projection6081_g79798 = lerpResult6757_g79798;
				half Overlay_Shading6688_g79798 = Blend_Albedo_Globals6410_g79798;
				half Overlay_Custom6707_g79798 = 1.0;
				float temp_output_7_0_g79848 = 0.1;
				float temp_output_10_0_g79848 = ( 0.2 - temp_output_7_0_g79848 );
				half Overlay_Mask_High6064_g79798 = saturate( ( ( ( Overlay_Value5738_g79798 * Overlay_Projection6081_g79798 * Overlay_Shading6688_g79798 * Overlay_Custom6707_g79798 ) - temp_output_7_0_g79848 ) / ( temp_output_10_0_g79848 + 0.0001 ) ) );
				half Overlay_Mask269_g79798 = Overlay_Mask_High6064_g79798;
				float3 lerpResult336_g79798 = lerp( Blend_Albedo_Colored863_g79798 , Global_OverlayColor1758_g79798 , Overlay_Mask269_g79798);
				half3 Blend_Albedo_Overlay359_g79798 = lerpResult336_g79798;
				half Global_WetnessContrast6502_g79798 = TVE_WetnessContrast;
				half Global_Extras_Wetness305_g79798 = break456_g79805.y;
				half Wetness_Value6343_g79798 = ( Global_Extras_Wetness305_g79798 * _GlobalWetness );
				float3 lerpResult6367_g79798 = lerp( Blend_Albedo_Overlay359_g79798 , ( Blend_Albedo_Overlay359_g79798 * Blend_Albedo_Overlay359_g79798 ) , ( Global_WetnessContrast6502_g79798 * Wetness_Value6343_g79798 ));
				half3 Blend_Albedo_Wetness6351_g79798 = lerpResult6367_g79798;
				
				half2 Blend_Normal312_g79798 = temp_output_7045_0_g79798;
				half Global_OverlayNormalScale6581_g79798 = TVE_OverlayNormalValue;
				float lerpResult6585_g79798 = lerp( 1.0 , Global_OverlayNormalScale6581_g79798 , Overlay_Mask269_g79798);
				half2 Blend_Normal_Overlay366_g79798 = ( Blend_Normal312_g79798 * lerpResult6585_g79798 );
				half Global_WetnessNormalScale6571_g79798 = TVE_WetnessNormalValue;
				float lerpResult6579_g79798 = lerp( 1.0 , Global_WetnessNormalScale6571_g79798 , ( Wetness_Value6343_g79798 * Wetness_Value6343_g79798 ));
				half2 Blend_Normal_Wetness6372_g79798 = ( Blend_Normal_Overlay366_g79798 * lerpResult6579_g79798 );
				float3 appendResult6568_g79798 = (float3(Blend_Normal_Wetness6372_g79798 , 1.0));
				
				float3 temp_cast_17 = (0.0).xxx;
				float3 lerpResult7362_g79798 = lerp( float3( 1,1,1 ) , (Terrain_Albedo6800_g79798).xyz , _EmissiveAlbedoMode);
				half3 Emissive_Color7279_g79798 = ( (_EmissiveColor).rgb * (Terrain_Specular7322_g79798).rgb * lerpResult7362_g79798 );
				half Emissive_Texture7282_g79798 = (Terrain_Albedo6800_g79798).w;
				half Global_Extras_Emissive4203_g79798 = break456_g79805.x;
				float lerpResult7266_g79798 = lerp( 1.0 , Global_Extras_Emissive4203_g79798 , _GlobalEmissive);
				half Emissive_Value7264_g79798 = ( lerpResult7266_g79798 * _EmissivePhaseValue );
				half Emissive_Mask7291_g79798 = saturate( ( Emissive_Texture7282_g79798 + ( Emissive_Value7264_g79798 - 1.0 ) ) );
				float3 temp_output_3_0_g79858 = ( Emissive_Color7279_g79798 * Emissive_Mask7291_g79798 );
				float temp_output_15_0_g79858 = _emissive_intensity_value;
				float3 hdEmission22_g79858 = ASEGetEmissionHDRColor(temp_output_3_0_g79858,temp_output_15_0_g79858,_EmissiveExposureValue,GetInverseCurrentExposureMultiplier());
				#ifdef TVE_EMISSIVE
				float3 staticSwitch7437_g79798 = hdEmission22_g79858;
				#else
				float3 staticSwitch7437_g79798 = temp_cast_17;
				#endif
				half3 Blend_Emissive7261_g79798 = staticSwitch7437_g79798;
				
				#ifdef TVE_PACKED_TEX
				float staticSwitch8571_g83242 = 0.0;
				#else
				float staticSwitch8571_g83242 = ( (Blend_Masks7420_g83242).x * (Blend_Params7547_g83242).x );
				#endif
				#ifdef TVE_PACKED_TEX
				float staticSwitch8559_g83242 = 1.0;
				#else
				float staticSwitch8559_g83242 = (Blend_Masks7420_g83242).y;
				#endif
				#ifdef TVE_PACKED_TEX
				float staticSwitch8560_g83242 = (Blend_Masks7420_g83242).x;
				#else
				float staticSwitch8560_g83242 = (Blend_Masks7420_g83242).w;
				#endif
				float4 appendResult8574_g83242 = (float4(staticSwitch8571_g83242 , staticSwitch8559_g83242 , (Blend_Masks7420_g83242).z , ( staticSwitch8560_g83242 * (Blend_Params7547_g83242).w )));
				half4 Terrain_Masks7251_g79798 = appendResult8574_g83242;
				half Blend_Smoothness314_g79798 = ( (Terrain_Masks7251_g79798).w * _TerrainSmoothnessValue );
				half Global_OverlaySmoothness311_g79798 = TVE_OverlaySmoothness;
				float lerpResult343_g79798 = lerp( Blend_Smoothness314_g79798 , Global_OverlaySmoothness311_g79798 , Overlay_Mask269_g79798);
				half Blend_Smoothness_Overlay371_g79798 = lerpResult343_g79798;
				float temp_output_6499_0_g79798 = ( 1.0 - Wetness_Value6343_g79798 );
				half Blend_Smoothness_Wetness4130_g79798 = saturate( ( Blend_Smoothness_Overlay371_g79798 + ( 1.0 - ( temp_output_6499_0_g79798 * temp_output_6499_0_g79798 ) ) ) );
				
				float lerpResult7046_g79798 = lerp( 1.0 , (Terrain_Masks7251_g79798).y , _TerrainOcclusionValue);
				half Blend_Occlusion7306_g79798 = lerpResult7046_g79798;
				
				float localCustomAlphaClip19_g83341 = ( 0.0 );
				half Terrain_Holes7437_g83242 = SAMPLE_TEXTURE2D( _HolesTex, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 ).r;
				half Terrain_Holes7159_g79798 = Terrain_Holes7437_g83242;
				half Global_Extras_Alpha1033_g79798 = saturate( break456_g79805.w );
				float lerpResult7479_g79798 = lerp( 1.0 , Global_Extras_Alpha1033_g79798 , _GlobalAlpha);
				half Alpha_Global7481_g79798 = lerpResult7479_g79798;
				half AlphaTreshold2132_g79798 = _AlphaClipValue;
				float temp_output_3_0_g83341 = ( ( Terrain_Holes7159_g79798 * Alpha_Global7481_g79798 ) - AlphaTreshold2132_g79798 );
				float Alpha19_g83341 = temp_output_3_0_g83341;
				float temp_output_15_0_g83341 = 0.01;
				float Treshold19_g83341 = temp_output_15_0_g83341;
				{
				#if defined (TVE_ALPHA_CLIP) || defined (TVE_ALPHA_FADE) || defined (TVE_ALPHA_GLOBAL)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#else
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#endif
				}
				
				surfaceDescription.BaseColor = Blend_Albedo_Wetness6351_g79798;
				surfaceDescription.Normal = appendResult6568_g79798;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = Blend_Emissive7261_g79798;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g79798;
				surfaceDescription.Occlusion = Blend_Occlusion7306_g79798;
				surfaceDescription.Alpha = Alpha19_g83341;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif

				#ifdef ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);

				PreLightData preLightData = GetPreLightData(V, posInput, bsdfData);

				outColor = float4(0.0, 0.0, 0.0, 0.0);

				#ifdef DEBUG_DISPLAY
				#ifdef OUTPUT_SPLIT_LIGHTING
					outDiffuseLighting = float4(0, 0, 0, 1);
					ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
				#endif

			    bool viewMaterial = GetMaterialDebugColor(outColor, input, builtinData, posInput, surfaceData, bsdfData);

				if (!viewMaterial)
				{
					if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_DIFFUSE_COLOR || _DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_SPECULAR_COLOR)
					{
						float3 result = float3(0.0, 0.0, 0.0);
						GetPBRValidatorDebug(surfaceData, result);
						outColor = float4(result, 1.0f);
					}
					else if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_TRANSPARENCY_OVERDRAW)
					{
						float4 result = _DebugTransparencyOverdrawWeight * float4(TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_A);
						outColor = result;
					}
					else
                #endif
					{
                #ifdef _SURFACE_TYPE_TRANSPARENT
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_TRANSPARENT;
                #else
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_OPAQUE;
                #endif
						LightLoopOutput lightLoopOutput;
						LightLoop(V, posInput, preLightData, bsdfData, builtinData, featureFlags, lightLoopOutput);

						// Alias
						float3 diffuseLighting = lightLoopOutput.diffuseLighting;
						float3 specularLighting = lightLoopOutput.specularLighting;

						diffuseLighting *= GetCurrentExposureMultiplier();
						specularLighting *= GetCurrentExposureMultiplier();

                #ifdef OUTPUT_SPLIT_LIGHTING
						if (_EnableSubsurfaceScattering != 0 && ShouldOutputSplitLighting(bsdfData))
						{
							outColor = float4(specularLighting, 1.0);
							outDiffuseLighting = float4(TagLightingForSSS(diffuseLighting), 1.0);
						}
						else
						{
							outColor = float4(diffuseLighting + specularLighting, 1.0);
							outDiffuseLighting = float4(0, 0, 0, 1);
						}
						ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
                #else
						outColor = ApplyBlendMode(diffuseLighting, specularLighting, builtinData.opacity);
						outColor = EvaluateAtmosphericScattering(posInput, V, outColor);
                #endif

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						float4 VPASSpositionCS = float4(packedInput.vpassPositionCS.xy, 0.0, packedInput.vpassPositionCS.z);
						float4 VPASSpreviousPositionCS = float4(packedInput.vpassPreviousPositionCS.xy, 0.0, packedInput.vpassPreviousPositionCS.z);
						bool forceNoMotion = any(unity_MotionVectorsParams.yw == 0.0);
                #if defined(HAVE_VFX_MODIFICATION) && !VFX_FEATURE_MOTION_VECTORS
                        forceNoMotion = true;
                #endif
				        if (!forceNoMotion)
						{
							float2 motionVec = CalculateMotionVector(VPASSpositionCS, VPASSpreviousPositionCS);
							EncodeMotionVector(motionVec * 0.5, outMotionVec);
							outMotionVec.zw = 1.0;
						}
				#endif
				}

				#ifdef DEBUG_DISPLAY
				}
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

                #ifdef UNITY_VIRTUAL_TEXTURING
				    float vtAlphaValue = builtinData.opacity;
                    #if defined(HAS_REFRACTION) && HAS_REFRACTION
					vtAlphaValue = 1.0f - bsdfData.transmittanceMask;
                #endif
				outVTFeedback = PackVTFeedbackWithAlpha(builtinData.vtPackedFeedback, input.positionSS.xy, vtAlphaValue);
                #endif

			}
			ENDHLSL
		}

		UsePass "Hidden/Nature/Terrain/Utilities/PICKING"
	UsePass "Hidden/Nature/Terrain/Utilities/SELECTION"

		Pass
        {
			
            Name "ScenePickingPass"
            Tags { "LightMode"="Picking" }

            Cull [_CullMode]

            HLSLPROGRAM
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#pragma shader_feature_local_fragment _ _DISABLE_DECALS
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140011
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma editor_sync_compilation
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENEPICKINGPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define VARYINGS_NEED_TANGENT_TO_WORLD

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

            #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
            #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
	
            CBUFFER_START( UnityPerMaterial )
			half4 _MaskMax8;
			half4 _Coords7;
			half4 _MaskMax6;
			half4 _MaskMin6;
			half4 _Coords6;
			half4 _MaskMax5;
			half4 _MaskMin5;
			half4 _Coords5;
			half4 _MaskMax4;
			half4 _MaskMin4;
			half4 _MaskMin7;
			half4 _Coords4;
			half4 _MaskMin3;
			half4 _Coords3;
			half4 _MaskMax2;
			half4 _MaskMin2;
			half4 _Coords2;
			half4 _MaskMax1;
			half4 _MaskMin1;
			half4 _Coords1;
			half4 _MaskMax16;
			half4 _MaskMax3;
			half4 _MaskMax7;
			half4 _Coords8;
			half4 _MaskMin8;
			half4 _MaskMin15;
			half4 _Coords15;
			half4 _MaskMax14;
			half4 _MaskMin14;
			half4 _Coords14;
			half4 _MaskMax13;
			half4 _MaskMin13;
			half4 _Coords13;
			half4 _MaskMax12;
			half4 _MaskMin12;
			half4 _Coords12;
			half4 _MaskMax11;
			half4 _MaskMin11;
			half4 _Coords11;
			half4 _MaskMax10;
			half4 _MaskMin10;
			half4 _Coords10;
			half4 _MaskMax9;
			half4 _MaskMin9;
			half4 _Coords9;
			half4 _MaskMin16;
			half4 _TerrainColor;
			half4 _MaskMax15;
			half4 _Coords16;
			half4 _Params5;
			half4 _Params2;
			half4 _Params3;
			half4 _Params4;
			half4 _Params6;
			half4 _Params7;
			half4 _Params8;
			half4 _Params1;
			half4 _Params9;
			half4 _Params11;
			half4 _Params12;
			half4 _Params13;
			half4 _Params14;
			half4 _Params15;
			half4 _Params16;
			half4 _Params10;
			half4 _Specular16;
			half4 _EmissiveColor;
			half4 _Specular7;
			half4 _Specular3;
			half4 _Specular4;
			half4 _Specular5;
			half4 _Specular6;
			half4 _Specular15;
			half4 _Specular8;
			half4 _Specular2;
			half4 _Specular9;
			half4 _Specular11;
			half4 _Specular12;
			half4 _Specular13;
			half4 _Specular14;
			half4 _Specular10;
			half4 _Specular1;
			half _EmissivePhaseValue;
			half _GlobalEmissive;
			half _TerrainSmoothnessValue;
			float _emissive_intensity_value;
			half _EmissiveAlbedoMode;
			half _TerrainOcclusionValue;
			half _EmissiveExposureValue;
			half _GlobalColors;
			half _OverlayProjectionValue;
			half _TerrainNormalValue;
			half _ColorsIntensityValue;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _TerrainHeightBlendValue;
			half _GlobalWetness;
			half _LayerColorsValue;
			half _CategoryGlobals;
			half _GlobalHeight;
			half _CategoryEmissive;
			half _CategoryMotion;
			half _EmissiveIntensityValue;
			half _EmissiveIntensityMode;
			half _EmissiveFlagMode;
			half _IsVersion;
			half _IsTerrainShader;
			half _CategoryRender;
			half _MessageTerrainEmissive;
			half _MessageTerrainColors;
			half _CategoryTerrain;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _IsCustomShader;
			half _IsShared;
			half _IsCollected;
			half _IsIdentifier;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceGlobalOptions;
			half _SpaceGlobalLocals;
			half _SpaceGlobalLayers;
			half _CategoryLayers;
			half _GlobalAlpha;
			half _TerrainLayersMode;
			half _TerrainBlendMode;
			half _LayerVertexValue;
			half _RenderClip;
			half _LayerSampleMode16;
			half _LayerSampleMode15;
			half _LayerSampleMode14;
			half _LayerSampleMode13;
			half _LayerSampleMode12;
			half _LayerSampleMode11;
			half _LayerSampleMode10;
			half _LayerSampleMode9;
			half _LayerSampleMode8;
			half _LayerSampleMode7;
			half _LayerSampleMode6;
			half _LayerSampleMode5;
			half _LayerSampleMode1;
			half _LayerSampleMode4;
			half _LayerSampleMode3;
			half _LayerSampleMode2;
			half _CategoryInputs;
			half _TerrainTexMode;
			half _RenderMode;
			half _RenderDecals;
			half _EmissiveMode;
			half _MessageTerrainMasks;
			half _AlphaClipValue;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif

			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			SAMPLER(sampler_Linear_Clamp);
			half4 TVE_VertexParams;
			TEXTURE2D(_HolesTex);
			SAMPLER(sampler_Linear_Clamp_Aniso8);
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
				TEXTURE2D(_TerrainHeightmapTexture);//ASE Terrain Instancing
				TEXTURE2D( _TerrainNormalmapTexture);//ASE Terrain Instancing
				SAMPLER(sampler_TerrainNormalmapTexture);//ASE Terrain Instancing
			#endif//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_START( Terrain )//ASE Terrain Instancing
				UNITY_DEFINE_INSTANCED_PROP( float4, _TerrainPatchInstanceData )//ASE Terrain Instancing
			UNITY_INSTANCING_BUFFER_END( Terrain)//ASE Terrain Instancing
			CBUFFER_START( UnityTerrain)//ASE Terrain Instancing
				#ifdef UNITY_INSTANCING_ENABLED//ASE Terrain Instancing
					float4 _TerrainHeightmapRecipSize;//ASE Terrain Instancing
					float4 _TerrainHeightmapScale;//ASE Terrain Instancing
				#endif//ASE Terrain Instancing
			CBUFFER_END//ASE Terrain Instancing


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment TVE_ALPHA_CLIP
			#pragma multi_compile_instancing
			#pragma instancing_options assumeuniformscaling nomatrices nolightprobe nolightmap forwardadd
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float3 previousPositionOS : TEXCOORD4;
				float3 precomputedVelocity : TEXCOORD5;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 uv1 : TEXCOORD3;
				float4 uv2 : TEXCOORD4;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 vpassPositionCS : TEXCOORD5;
					float3 vpassPreviousPositionCS : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			AttributesMesh ApplyMeshModification( AttributesMesh inputMesh )
			{
			#ifdef UNITY_INSTANCING_ENABLED
				float2 patchVertex = inputMesh.positionOS.xy;
				float4 instanceData = UNITY_ACCESS_INSTANCED_PROP( Terrain, _TerrainPatchInstanceData );
				float2 sampleCoords = ( patchVertex.xy + instanceData.xy ) * instanceData.z;
				float height = UnpackHeightmap( _TerrainHeightmapTexture.Load( int3( sampleCoords, 0 ) ) );
				inputMesh.positionOS.xz = sampleCoords* _TerrainHeightmapScale.xz;
				inputMesh.positionOS.y = height* _TerrainHeightmapScale.y;
				#ifdef ENABLE_TERRAIN_PERPIXEL_NORMAL
					inputMesh.normalOS = float3(0, 1, 0);
				#else
					inputMesh.normalOS = _TerrainNormalmapTexture.Load(int3(sampleCoords, 0)).rgb* 2 - 1;
				#endif
				inputMesh.ase_texcoord.xy = sampleCoords* _TerrainHeightmapRecipSize.zw;
			#endif
				return inputMesh;
			}
			

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(PickingSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif  
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                //BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);

            }

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				inputMesh = ApplyMeshModification(inputMesh);
				float3 VertexPosition3588_g79798 = inputMesh.positionOS;
				float temp_output_84_0_g79811 = _LayerVertexValue;
				float temp_output_19_0_g79815 = TVE_VertexUsage[(int)temp_output_84_0_g79811];
				float4 temp_output_94_19_g79811 = TVE_VertexCoords;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag7344_g79798 = ase_worldPos;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV97_g79811 = ( (temp_output_94_19_g79811).zw + ( (temp_output_94_19_g79811).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode50_g79811 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g79811,temp_output_84_0_g79811, 0.0 );
				float4 temp_output_17_0_g79815 = tex2DArrayNode50_g79811;
				float4 temp_output_111_19_g79811 = TVE_VertexParams;
				float4 temp_output_3_0_g79815 = temp_output_111_19_g79811;
				float4 ifLocalVar18_g79815 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79815 >= 0.5 )
				ifLocalVar18_g79815 = temp_output_17_0_g79815;
				else
				ifLocalVar18_g79815 = temp_output_3_0_g79815;
				float4 lerpResult22_g79815 = lerp( temp_output_3_0_g79815 , temp_output_17_0_g79815 , temp_output_19_0_g79815);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79815 = lerpResult22_g79815;
				#else
				float4 staticSwitch24_g79815 = ifLocalVar18_g79815;
				#endif
				half4 Global_Vertex_Params4173_g79798 = staticSwitch24_g79815;
				float4 break322_g79802 = Global_Vertex_Params4173_g79798;
				half Global_VertexOffset7327_g79798 = break322_g79802.z;
				float3 appendResult7336_g79798 = (float3(0.0 , ( Global_VertexOffset7327_g79798 * _GlobalHeight ) , 0.0));
				half3 Vertex_Offset7335_g79798 = appendResult7336_g79798;
				float3 Vertex_Output890_g79798 = ( VertexPosition3588_g79798 + Vertex_Offset7335_g79798 );
				
				float4 appendResult7007_g79798 = (float4(cross( inputMesh.normalOS , float3(0,0,1) ) , -1.0));
				half4 Vertex_Tangents7390_g79798 = appendResult7007_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord8.xyz = vertexToFrag7344_g79798;
				
				outputPackedVaryingsMeshToPS.ase_texcoord7.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord7.zw = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  Vertex_Output890_g79798;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS = Vertex_Tangents7390_g79798;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(positionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}
				#endif

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.uv1.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.uv2.xyzw = inputMesh.uv2;

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outputPackedVaryingsMeshToPS.vpassPositionCS = float3(VPASSpositionCS.xyw);
					outputPackedVaryingsMeshToPS.vpassPreviousPositionCS = float3(VPASSpreviousPositionCS.xyw);
				#endif
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif

						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
			UNITY_SETUP_INSTANCE_ID(packedInput);

				float3 positionRWS = packedInput.positionRWS.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				PickingSurfaceDescription surfaceDescription = (PickingSurfaceDescription)0;
				float localCustomAlphaClip19_g83341 = ( 0.0 );
				float2 Terrain_Control_UV7873_g83242 = packedInput.ase_texcoord7.xy;
				half Terrain_Holes7437_g83242 = SAMPLE_TEXTURE2D( _HolesTex, sampler_Linear_Clamp_Aniso8, Terrain_Control_UV7873_g83242 ).r;
				half Terrain_Holes7159_g79798 = Terrain_Holes7437_g83242;
				float temp_output_84_0_g79816 = _LayerExtrasValue;
				float temp_output_19_0_g79820 = TVE_ExtrasUsage[(int)temp_output_84_0_g79816];
				float4 temp_output_93_19_g79816 = TVE_ExtrasCoords;
				float3 vertexToFrag7344_g79798 = packedInput.ase_texcoord8.xyz;
				float3 WorldPosition3905_g79798 = vertexToFrag7344_g79798;
				half2 UV96_g79816 = ( (temp_output_93_19_g79816).zw + ( (temp_output_93_19_g79816).xy * (WorldPosition3905_g79798).xz ) );
				float4 tex2DArrayNode48_g79816 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g79816,temp_output_84_0_g79816, 0.0 );
				float4 temp_output_17_0_g79820 = tex2DArrayNode48_g79816;
				float4 temp_output_94_85_g79816 = TVE_ExtrasParams;
				float4 temp_output_3_0_g79820 = temp_output_94_85_g79816;
				float4 ifLocalVar18_g79820 = 0;
				UNITY_BRANCH 
				if( temp_output_19_0_g79820 >= 0.5 )
				ifLocalVar18_g79820 = temp_output_17_0_g79820;
				else
				ifLocalVar18_g79820 = temp_output_3_0_g79820;
				float4 lerpResult22_g79820 = lerp( temp_output_3_0_g79820 , temp_output_17_0_g79820 , temp_output_19_0_g79820);
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch24_g79820 = lerpResult22_g79820;
				#else
				float4 staticSwitch24_g79820 = ifLocalVar18_g79820;
				#endif
				half4 Global_Extras_Params5440_g79798 = staticSwitch24_g79820;
				float4 break456_g79805 = Global_Extras_Params5440_g79798;
				half Global_Extras_Alpha1033_g79798 = saturate( break456_g79805.w );
				float lerpResult7479_g79798 = lerp( 1.0 , Global_Extras_Alpha1033_g79798 , _GlobalAlpha);
				half Alpha_Global7481_g79798 = lerpResult7479_g79798;
				half AlphaTreshold2132_g79798 = _AlphaClipValue;
				float temp_output_3_0_g83341 = ( ( Terrain_Holes7159_g79798 * Alpha_Global7481_g79798 ) - AlphaTreshold2132_g79798 );
				float Alpha19_g83341 = temp_output_3_0_g83341;
				float temp_output_15_0_g83341 = 0.01;
				float Treshold19_g83341 = temp_output_15_0_g83341;
				{
				#if defined (TVE_ALPHA_CLIP) || defined (TVE_ALPHA_FADE) || defined (TVE_ALPHA_GLOBAL)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined(SHADERPASS_FORWARD_BYPASS_ALPHA_TEST) && !defined(SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#else
				clip(Alpha19_g83341 - Treshold19_g83341);
				#endif
				#endif
				}
				
				surfaceDescription.Alpha = Alpha19_g83341;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;
				#endif

				outColor = _SelectionID;
			}

            ENDHLSL
		}

        Pass
        {

            Name "FullScreenDebug"
            Tags 
			{ 
				"LightMode" = "FullScreenDebug" 
            }

            Cull [_CullMode]
			ZTest LEqual
			ZWrite Off

            HLSLPROGRAM
            /*ase_pragma_before*/
            #pragma multi_compile _ DOTS_INSTANCING_ON

			#pragma vertex Vert
			#pragma fragment Frag

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#define SHADERPASS SHADERPASS_FULL_SCREEN_DEBUG

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
		    #define OUTPUT_SPLIT_LIGHTING
		    #endif

            #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
            #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC;
				#endif
			};

			struct VaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
			};

			struct VertexDescriptionInputs
			{
				 float3 ObjectSpaceNormal;
				 float3 ObjectSpaceTangent;
				 float3 ObjectSpacePosition;
			};

			struct SurfaceDescriptionInputs
			{
				 float3 TangentSpaceNormal;
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
			};

            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
			{
				PackedVaryingsMeshToPS output;
				ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
				output.positionCS = input.positionCS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				return output;
			}

			VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
			{
				VaryingsMeshToPS output;
				output.positionCS = input.positionCS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				return output;
			}

            struct VertexDescription
			{
				float3 Position;
				float3 Normal;
				float3 Tangent;
			};

			VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
			{
				VertexDescription description = (VertexDescription)0;
				description.Position = IN.ObjectSpacePosition;
				description.Normal = IN.ObjectSpaceNormal;
				description.Tangent = IN.ObjectSpaceTangent;
				return description;
			}

            struct SurfaceDescription
			{
				float3 BaseColor;
				float3 Emission;
				float Alpha;
				float3 BentNormal;
				float Smoothness;
				float Occlusion;
				float3 NormalTS;
				float Metallic;
			};

			SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
			{
				SurfaceDescription surface = (SurfaceDescription)0;
				surface.BaseColor = IsGammaSpace() ? float3(0.5, 0.5, 0.5) : SRGBToLinear(float3(0.5, 0.5, 0.5));
				surface.Emission = float3(0, 0, 0);
				surface.Alpha = 1;
				surface.BentNormal = IN.TangentSpaceNormal;
				surface.Smoothness = 0.5;
				surface.Occlusion = 1;
				surface.NormalTS = IN.TangentSpaceNormal;
				surface.Metallic = 0;
				return surface;
			}

			VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
			{
				VertexDescriptionInputs output;
				ZERO_INITIALIZE(VertexDescriptionInputs, output);

				output.ObjectSpaceNormal =                          input.normalOS;
				output.ObjectSpaceTangent =                         input.tangentOS.xyz;
				output.ObjectSpacePosition =                        input.positionOS;

				return output;
			}

			AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters  )
			{
				VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);

				VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);

				input.positionOS = vertexDescription.Position;
				input.normalOS = vertexDescription.Normal;
				input.tangentOS.xyz = vertexDescription.Tangent;
				return input;
			}

			FragInputs BuildFragInputs(VaryingsMeshToPS input)
			{
				FragInputs output;
				ZERO_INITIALIZE(FragInputs, output);

				output.tangentToWorld = k_identity3x3;
				output.positionSS = input.positionCS; // input.positionCS is SV_Position

				return output;
			}

			FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
			{
				UNITY_SETUP_INSTANCE_ID(input);
				VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
				return BuildFragInputs(unpacked);
			}

			#define DEBUG_DISPLAY
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/FullScreenDebug.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/VertMesh.hlsl"

			PackedVaryingsType Vert(AttributesMesh inputMesh)
			{
				VaryingsType varyingsType;
				varyingsType.vmesh = VertMesh(inputMesh);
				return PackVaryingsType(varyingsType);
			}

			#if !defined(_DEPTHOFFSET_ON)
			[earlydepthstencil]
			#endif
			void Frag(PackedVaryingsToPS packedInput)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				FragInputs input = UnpackVaryingsToFragInputs(packedInput);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz);

			#ifdef PLATFORM_SUPPORTS_PRIMITIVE_ID_IN_PIXEL_SHADER
				if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_QUAD_OVERDRAW)
				{
					IncrementQuadOverdrawCounter(posInput.positionSS.xy, input.primitiveID);
				}
			#endif
			}
            ENDHLSL
        }
		
	}
	
	CustomEditor "TVEShaderCoreGUI"
	
	Fallback Off
}
/*ASEBEGIN
Version=19303
Node;AmplifyShaderEditor.FunctionNode;562;-1280,640;Inherit;False;Define Terrain HD;-1;;79617;fcbff1804ae9c554d92a2efa638dc3d8;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.FunctionNode;560;-1280,0;Inherit;False;Base Terrain;0;;79798;d7fdb34559d910d4d9869fcb74eee2c3;29,4028,1,3900,1,3908,1,4172,1,4179,1,4499,1,1708,1,6056,1,3509,1,7483,1,1718,1,1717,1,6116,1,1715,1,1714,1,6592,1,6068,1,6076,1,6692,0,6729,1,3475,1,6352,1,6378,1,6655,1,7271,1,3243,1,4217,1,5090,1,5339,0;3;6196;FLOAT;1;False;6693;FLOAT;1;False;5340;FLOAT3;0,0,0;False;16;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4842;FLOAT;529;FLOAT3;3678;FLOAT;530;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT;532;FLOAT;721;FLOAT;629;FLOAT3;534;FLOAT4;6919
Node;AmplifyShaderEditor.FunctionNode;564;-416,640;Inherit;False;Compile Terrain;-1;;83343;6d8156013e46d8f4d90356b3a77e1200;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;565;-640,640;Inherit;False;Compile All Shaders;-1;;83344;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;550;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;META;0;1;META;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;551;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;552;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;3;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;553;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;DepthOnly;0;4;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefDepth;255;False;;255;True;_StencilWriteMaskDepth;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;554;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;MotionVectors;0;5;MotionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefMV;255;False;;255;True;_StencilWriteMaskMV;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;True;1;False;;False;False;True;1;LightMode=MotionVectors;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;555;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;TransparentBackface;0;6;TransparentBackface;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelOne;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelTwo;False;False;False;False;False;True;0;True;_ZWrite;True;0;True;_ZTestTransparent;False;True;1;LightMode=TransparentBackface;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;556;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;TransparentDepthPrepass;0;7;TransparentDepthPrepass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefDepth;255;False;;255;True;_StencilWriteMaskDepth;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;True;1;False;;False;False;True;1;LightMode=TransparentDepthPrepass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;557;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;TransparentDepthPostpass;0;8;TransparentDepthPostpass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=TransparentDepthPostpass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;558;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Forward;0;9;Forward;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;True;_CullModeForward;False;False;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelOne;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelTwo;False;False;False;True;True;0;True;_StencilRef;255;False;;255;True;_StencilWriteMask;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;True;0;True;_ZWrite;True;0;True;_ZTestDepthEqualForOpaque;False;True;1;LightMode=Forward;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;559;-464,0;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;10;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;3;False;;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;549;-448,0;Float;False;True;-1;2;TVEShaderCoreGUI;0;15;BOXOPHOBIC/The Vegetation Engine/Landscape/Terrain Standard Lit;28cd5599e02859647ae1798e4fcaef6c;True;GBuffer;0;0;GBuffer;34;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;4;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;TerrainCompatible=True;True;5;True;9;d3d11;metal;vulkan;xboxone;xboxseries;playstation;ps4;ps5;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;True;True;True;True;0;True;_LightLayersMaskBuffer4;False;False;False;False;False;False;False;True;True;0;True;_StencilRefGBuffer;255;False;;255;True;_StencilWriteMaskGBuffer;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;False;True;0;True;_ZTestGBuffer;False;True;1;LightMode=GBuffer;False;False;0;;0;0;Standard;38;Surface Type;0;0;  Rendering Pass;1;0;  Refraction Model;0;0;    Blending Mode;0;0;    Blend Preserves Specular;1;0;  Back Then Front Rendering;0;0;  Transparent Depth Prepass;0;0;  Transparent Depth Postpass;0;0;  ZWrite;0;0;  Z Test;4;0;Double-Sided;0;0;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Material Type,InvertActionOnDeselection;0;0;  Energy Conserving Specular;1;0;  Transmission,InvertActionOnDeselection;0;0;Receive Decals;1;638290890026126062;Receive SSR;1;0;Receive SSR Transparent;0;0;Motion Vectors;0;638280768141928017;  Add Precomputed Velocity;0;0;Specular AA;0;0;Specular Occlusion Mode;1;0;Override Baked GI;0;0;Depth Offset;0;0;  Conserative;1;0;GPU Instancing;0;638281577018303324;LOD CrossFade;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position;0;638284142355332696;0;11;True;True;True;True;True;False;False;False;False;True;True;True;;True;0
Node;AmplifyShaderEditor.CommentaryNode;307;-1280,-128;Inherit;False;1022.896;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;310;-1280,512;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
WireConnection;549;0;560;0
WireConnection;549;1;560;528
WireConnection;549;6;560;2489
WireConnection;549;7;560;530
WireConnection;549;8;560;531
WireConnection;549;9;560;532
WireConnection;549;11;560;534
WireConnection;549;27;560;6919
ASEEND*/
//CHKSM=CCB872DE2445168028E9BE366F43F046EFD1662F
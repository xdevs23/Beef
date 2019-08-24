using System;
using Beefy.utils;

namespace IDE
{
	class BuildOptions
	{
		public enum LTOType
		{
			None,
			Thin,
		}

		public enum EmitDebugInfo
		{
		    No,
		    Yes,
		    LinesOnly,            
		}

		public enum SIMDSetting
		{
		    None,
		    MMX,
		    SSE,
		    SSE2,
		    SSE3,
		    SSE4,
		    SSE41,
		    AVX,
		    AVX2,            
		}

		public enum BfOptimizationLevel
		{
		    case O0;
		    case O1;
		    case O2;
		    case O3;
			case Og;
			case OgPlus;

			public bool IsOptimized()
			{
				return (this != .Og) && (this != .OgPlus) && (this != .O0);
			}
		}
	}

	public class DistinctBuildOptions
	{
		public enum CreateState
		{
			Normal,
			New,
			Deleted
		}
		public CreateState mCreateState;

		[Reflect]
		public String mFilter = new String() ~ delete _;
		[Reflect]
		public BuildOptions.SIMDSetting? mBfSIMDSetting;
		[Reflect]
		public BuildOptions.BfOptimizationLevel? mBfOptimizationLevel;
		[Reflect]
		public BuildOptions.EmitDebugInfo? mEmitDebugInfo;
		[Reflect]
		public bool? mRuntimeChecks;
		[Reflect]
		public bool? mInitLocalVariables;
		[Reflect]
		public bool? mEmitDynamicCastCheck;
		[Reflect]
		public bool? mEmitObjectAccessCheck; // Only valid with mObjectHasDebugFlags
		[Reflect]
		public int32? mAllocStackTraceDepth;

		public ~this()
		{
		}

		public DistinctBuildOptions Duplicate()
		{
			var newVal = new DistinctBuildOptions();
			newVal.mFilter.Set(mFilter);
			newVal.mBfSIMDSetting = mBfSIMDSetting;
			newVal.mBfOptimizationLevel = mBfOptimizationLevel;
			newVal.mEmitDebugInfo = mEmitDebugInfo;
			newVal.mRuntimeChecks = mRuntimeChecks;
			newVal.mInitLocalVariables = mInitLocalVariables;
			newVal.mEmitDynamicCastCheck = mEmitDynamicCastCheck;
			newVal.mEmitObjectAccessCheck = mEmitObjectAccessCheck;
			newVal.mAllocStackTraceDepth = mAllocStackTraceDepth;
			return newVal;
		}

		public void Deserialize(StructuredData data)
		{
			data.GetString("Filter", mFilter);
			if (data.Contains("BfSIMDSetting"))
				mBfSIMDSetting = data.GetEnum<BuildOptions.SIMDSetting>("BfSIMDSetting");
			if (data.Contains("BfOptimizationLevel"))
				mBfOptimizationLevel = data.GetEnum<BuildOptions.BfOptimizationLevel>("BfOptimizationLevel");
			if (data.Contains("EmitDebugInfo"))
				mEmitDebugInfo = data.GetEnum<BuildOptions.EmitDebugInfo>("EmitDebugInfo");
			if (data.Contains("RuntimeChecks"))
				mRuntimeChecks = data.GetBool("RuntimeChecks");
			if (data.Contains("InitLocalVariables"))
				mInitLocalVariables = data.GetBool("InitLocalVariables");
			if (data.Contains("EmitDynamicCastCheck"))
				mEmitDynamicCastCheck = data.GetBool("EmitDynamicCastCheck");
			if (data.Contains("EmitObjectAccessCheck"))
				mEmitObjectAccessCheck = data.GetBool("EmitObjectAccessCheck");
			if (data.Contains("AllocStackTraceDepth"))
				mAllocStackTraceDepth = data.GetInt("AllocStackTraceDepth");
		}
		
		public void Serialize(StructuredData data)
		{
			data.Add("Filter", mFilter);
			data.ConditionalAdd("BfSIMDSetting", mBfSIMDSetting);
			data.ConditionalAdd("BfOptimizationLevel", mBfOptimizationLevel);
			data.ConditionalAdd("EmitDebugInfo", mEmitDebugInfo);
			data.ConditionalAdd("RuntimeChecks", mRuntimeChecks);
			data.ConditionalAdd("InitLocalVariables", mInitLocalVariables);
			data.ConditionalAdd("EmitDynamicCastCheck", mEmitDynamicCastCheck);
			data.ConditionalAdd("EmitObjectAccessCheck", mEmitObjectAccessCheck);
			data.ConditionalAdd("AllocStackTraceDepth", mAllocStackTraceDepth);
		}
	}
}
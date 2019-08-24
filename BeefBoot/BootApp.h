#pragma once

#include "BeefBoot.h"
#include "BeefySysLib/FileStream.h"
#include "BeefySysLib/util/CritSect.h"
#include "BeefySysLib/util/String.h"
#include "BeefySysLib/util/Array.h"
#include "Compiler/BfSystem.h"

NS_BF_BEGIN

enum OutputPri
{
	OutputPri_Low,
	OutputPri_Normal,
	OutputPri_High,
	OutputPri_Warning,
	OutputPri_Error,
	OutputPri_Critical
};

enum Verbosity
{
	Verbosity_Quiet,
	Verbosity_Minimal,
	Verbosity_Normal,
	Verbosity_Detailed,
	Verbosity_Diagnostic,
};

class BootApp
{
public:
	CritSect mLogCritSect;
	FileStream mLogFile;
	Verbosity mVerbosity;
	BfTargetType mTargetType;
	bool mHadCmdLine;
	bool mShowedHelp;
	bool mHadErrors;
	Array<String> mRequestedSrc;
	BfOptLevel mOptLevel;
	BfToolsetType mToolset;	
	bool mEmitIR;
	String mBuildDir;
	String mWorkingDir;
	String mDefines;
	String mStartupObject;
	String mTargetPath;
	String mLinkParams;

	void* mSystem;
	void* mCompiler;	
	void* mProject;
	void* mPassInstance;

public:
	void Fail(const String & error);
	void OutputLine(const String& text, OutputPri outputPri = OutputPri_Normal);
	bool QueueRun(const String& fileName, const String& args, const String& workingDir, BfpSpawnFlags extraFlags);

	void QueueFile(const StringImpl& path);
	void QueuePath(const StringImpl& path);
	void DoCompile();
    void DoLinkMS();
    void DoLinkGNU();

public:
	BootApp();
	~BootApp();	

	bool HandleCmdLine(const String& cmd, const String& param);

	bool Init();
	bool Compile();
};

extern BootApp* gApp;

NS_BF_END
/*=============================================================================
// InternetLink: Parent class for Internet connection classes
Copyright 1998-2010 Epic Games, Inc. All Rights Reserved.
=============================================================================*/
class InternetLink extends Info
	native
	transient;

cpptext
{
	AInternetLink();
	void BeginDestroy();
	UBOOL Tick( FLOAT DeltaTime, enum ELevelTick TickType );	
	FSocket* GetSocket() 
	{ 
		return static_cast<FSocket*>(Socket);
	}
	FSocket* GetRemoteSocket() 
	{ 
		return static_cast<FSocket*>(RemoteSocket);
	}
	FResolveInfo*& GetResolveInfo()
	{
		return *(FResolveInfo**)&PrivateResolveInfo;
	}
}

//-----------------------------------------------------------------------------
// Types & Variables.

// An IP address.
struct IpAddr
{
	var int Addr;
	var int Port;
};

// Data receive mode.
// Cannot be set in default properties.
var enum ELinkMode
{
	MODE_Text, 
	MODE_Line,
	MODE_Binary
} LinkMode;

// MODE_Line behavior, how to receive/send lines
var enum ELineMode
{
	LMODE_auto,
	LMODE_DOS,	// CRLF
	LMODE_UNIX, // LF
	LMODE_MAC,	// LFCR
} InLineMode, OutLineMode; // OutLineMode: LMODE_auto == LMODE_DOS

// Internal
var	const pointer Socket{FSocket};  // (sockets are 64-bit on AMD64, so use "pointer").
var const int Port;
var	const pointer RemoteSocket{FSocket};
var private native const pointer PrivateResolveInfo;
var const int DataPending;

// Receive mode.
// If mode is MODE_Manual, received events will not be called.
// This means it is your responsibility to check the DataPending
// var and receive the data.
// Cannot be set in default properties.
var enum EReceiveMode
{
	RMODE_Manual,
	RMODE_Event
} ReceiveMode;

//-----------------------------------------------------------------------------
// Natives.

// Returns true if data is pending on the socket.
native function bool IsDataPending();

// Parses an Unreal URL into its component elements.
// Returns false if the URL was invalid.
native function bool ParseURL
(
	coerce string URL, 
	out string Addr, 
	out int PortNum, 
	out string LevelName,
	out string EntryName
);

// Resolve a domain or dotted IP.
// Nonblocking operation.  
// Triggers Resolved event if successful.
// Triggers ResolveFailed event if unsuccessful.
native function Resolve( coerce string Domain );

// Returns most recent winsock error.
native function int GetLastError();

// Convert an IP address to a string.
native function string IpAddrToString( IpAddr Arg );

// Convert a string to an IP
native function bool StringToIpAddr( string Str, out IpAddr Addr );

native function GetLocalIP(out IpAddr Arg );

//-----------------------------------------------------------------------------
// Events.

// Called when domain resolution is successful.
// The IpAddr struct Addr contains the valid address.
event Resolved( IpAddr Addr );

// Called when domain resolution fails.
event ResolveFailed();

defaultproperties
{
}

#define WHITELIST "ar_baggage.bsp"
#define WHITELIST_TAGS ""

public void OnPluginStart(){
	Handle h = OpenDirectory("maps");
	if (h)
	{
		char file[512],prefix[2][512];
		FileType type;
		while (ReadDirEntry(h, file, sizeof(file), type))
		{
			ExplodeString(file, "_", prefix, sizeof(prefix), sizeof(prefix[]));
			if ((type == FileType_File) && (StrContains(WHITELIST, file, false) == -1) && (StrContains(WHITELIST_TAGS,prefix[0],false) == -1))
			{
				Format(file, sizeof(file), "maps/%s", file);
				if (DeleteFile(file))
				{
					LogMessage("Deleted %s",file);
				}
				else
				{
					LogMessage("Failure on deleting %s",file);
				}
			}
		}
	} else
	{
		LogMessage("Failure on opening maps directory");
	}
	delete h;
}
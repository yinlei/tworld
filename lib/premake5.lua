-------------------------------------------------------------------------------
-- premake5.lua
-------------------------------------------------------------------------------
workspace "ALL"
	configurations { "Debug32", "Release32", "Debug64", "Release64"}
	location "build"

	filter "configurations:*32"
		architecture "x86"
	filter{}

	filter "configurations:*64"
		architecture "x86_64"
	filter{}

	filter "configurations:Debug*"
		defines {
			"DEBUG",
			"LPEG_DEBUG"
		}
		flags { "Symbols" }
	filter{}

	filter "configurations:Release*"
     	defines { "NDEBUG" }
      	optimize "On"
    filter{}

project "aes128"
	kind "SharedLib"
	language "c"
	includedirs {
		"./aes128/",
	}
	files {
		"./aes128/*.c",
	}

if _ACTION == "clean" then
	os.rmdir("build")
end

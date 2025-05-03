class ThemeFile:
    # STATIC VARIABLES
    # aliases for colours eg color1
    def __init__(self,Palette:dict,FilePath:str, HasVariables:bool):
        self.FilePath:str = FilePath
        self.Palette:dict = Palette
        self.HasVar:bool = HasVariables
    @property
    def MyFile(self) -> list[str]:
        with open (self.FilePath, 'r') as file:
            f = file.readlines()
            file.close
        return (f)
    @property
    def MyNewFile(self) -> list[str]:
        MyNewFile = self.MyFile
        for key, value in self.Palette.items():
            col = ChangingColour(key,value,self.MyFile)
            MyNewFile[col.LineNo] = col.NewLine
        return MyNewFile
    
    def SaveFile(self):
        f = self.MyNewFile
        with open (self.FilePath, 'w') as file:
            file.writelines(f)
            file.close
        


class ChangingColour:
    def __init__(self,ColourName:str,NewColourCode:str,File:list[str]):
        self.ColourName = ColourName
        self.NewColourCode = NewColourCode
        self.File = File
    @property
    def LineNo(self) -> int:
        lineno = int(0)
        line = "null"   
        # Finding the Line No. of our colour's declaration
        while self.ColourName.lower() not in line.lower():
            lineno += 1
            line = self.File[lineno]
            if lineno +1 == len(self.File):
                return -1
        if line.lower == ("#" + self.ColourName).lower():
            lineno += 1
            line = self.File[lineno]
        return lineno
    @property
    def _OldLine(self) -> str:
        return self.File[self.LineNo]
    @property
    def _OldColourCode(self) -> str:
        if self.LineNo == -1:
            return self._OldLine
        else:
            return "#" + (self._OldLine.split("#")[1])[:6]
    @property
    def NewLine(self) -> str:
        return self._OldLine.replace(self._OldColourCode,self.NewColourCode)
        
# todo: add a global array of filepath strings

Gruvbox =	{
    "RED": "#cc241d",
    "ORANGE": "#d65d0e",
    "YELLOW": "#d79921",
    "GREEN": "#98971a",
    "BLUE": "#458588",
    "PURPLE": "#b16286",
    "CYAN": "#689d6a",
    "GREY": "#a89984",
    # "DARKGREY": "#1d2021",
    # "BLACK": "#191919",

    "BG": "#282828",
    # "FG": thisdict["LIGHTGREY"],
    # "SP": AQUA,
}

KanagawaDecorations =	{
    "WHITE":   "#cbc093", "WHITE2":  "#DCD7BA",
    "RED":     "#C34043", "RED2":    "#E82424",
    "ORANGE":  "#FFA066", "ORANGE2": "#FF5D62",
    "YELLOW":  "#C0A36E", "YELLOW2": "#E6C384",
    "GREEN":   "#76946A", "GREEN2":  "#98BB6C",
    "CYAN":    "#6A9589", "CYAN2":   "#7AA89F",
    "BLUE":    "#7E9CD8", "BLUE2":   "#7FB4CA",
    "PURPLE":  "#957FB8", "PURPLE2": "#938AA9",
    "BG":      "#1F1F28", "FG":      "#DCD7BA",
    "BLACK":   "#16161d", "GREY":    "#727169",
    "SELECT":  "#2D4F67"
}


gruvboxi3 = ThemeFile(KanagawaDecorations,"/home/richard/dots/home/.config/i3/kanagawai3",True)
print (gruvboxi3.MyNewFile)
gruvboxi3.SaveFile()
#gruvboxi3blocks = ThemeFile(Gruvbox,"/home/richard/dots/home/.config/i3blocks/config")
#gruvboxi3blocks.SaveFile()


import std.stdio;
import std.string;
import std.file;
import std.regex;

class LoadData {
    public:
        string rootDir;             // root directory
        bool rootSet = false;       // root directory not set
        bool filesSet = false;      // files map is empty
        string[string] files;       // files in the directory
        int numFiles = 0;           // number of files read
        
        this() {
            writeln("Loading data sets ...");
        }
        
        ~this() {
            writeln("Finished processing data ...");
        }

        void setRootDir(string dir) {
            try {
                if (isDir(dir)) {
                    this.rootDir = dir;
                    this.rootSet = true;
                    writeln("Directory set to ", this.rootDir);
                } else {
                    throw new Exception("IOError: Path not found!");
                }
            } catch (Exception e){
                writeln(e.msg);
            }
        }

         void loadFiles() {
            if (this.rootSet) {
                foreach(string filename; dirEntries(this.rootDir, "*.csv", SpanMode.shallow)) {
                    writeln(filename);
                    File file = File(filename, "r");
                    while (!file.eof()) {
                        string line = chomp(file.readln());
                        line.split(",");
                    }
                    this.numFiles++;
                }
                this.filesSet = true;   // the files map is no longer empty
                writeln("Number of files read: ", this.numFiles);
            }
        }

        void printFiles() {
            if (this.filesSet) {

            }
        }
       

}



void main(string[] args) {
    auto filePath = "/Users/williamrobertmurphy/Downloads/barcelona-data-sets";
    LoadData data_pipeline = new LoadData();
    data_pipeline.setRootDir(filePath);
    data_pipeline.loadFiles();
}

import os.path
import os

VERSION='23.4'

EMACS_FOLDER='emacs-%s' % (VERSION)
GNU_ZIP='emacs-%s-bin-i386.zip' % (VERSION)
GNU_URL='http://ftp.gnu.org/pub/gnu/emacs/windows/%s' % (GNU_ZIP)

def download(force=False):
    if os.path.isfile(GNU_ZIP):
        if force:
            os.unlink(GNU_ZIP)
        else:
            return
    print('Downloading %s from gnu.org' % (GNU_ZIP))
    try:
        import urllib.request
        retriever = urllib.request
    except ImportError:
        import urllib
        retriever = urllib
    retriever.urlretrieve(GNU_URL, GNU_ZIP)

def unpack(force=False):
    if os.path.isdir(EMACS_FOLDER):
        if force:
            import shutil
            print('Cleaning up folder %s' % (EMACS_FOLDER))
            shutil.rmtree(EMACS_FOLDER)
        else:
            return
    print('Unpacking archive to %s' %(EMACS_FOLDER))
    import zipfile
    zipf = zipfile.ZipFile(GNU_ZIP)
    zipf.extractall()

def build(inno_compiler):
    import subprocess
    try:
        subprocess.call([inno_compiler, "emacs.iss"])
        return 0
    except:
        print("Cannot find Inno Setup's ISCC.exe in the PATH.")
        print("Fix the PATH, or use -c \"C:\\path\\to\\iscc.exe\".")
        print("You can find Inno Setup at http://www.jrsoftware.org/")
        return 1

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description="Build installer for emacs")
    parser.add_argument('-f', action='store_const', const=True, default=False,
                        help='Force download and unpack')
    parser.add_argument('-c', metavar='inno_compiler', default='iscc.exe',
                        help='Compiler to use (path to iscc.exe)')
    args = parser.parse_args()
    download(args.f)
    unpack(args.f)
    exit(build(args.c))

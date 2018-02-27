import subprocess

def main():
    print("Goodbye, Cruel Python World!")
    subprocess.call(['java', '-jar', 'java-hello.jar'])

if __name__ == "__main__":
    main()
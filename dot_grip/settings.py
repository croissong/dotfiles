def find_password(username):
    import subprocess

    cmd = f"gopass -o github.com/{username}"
    pwinfo = subprocess.run(cmd, shell=True, check=True, capture_output=True)
    return pwinfo.stdout


QUIET = True
USERNAME = "jan.moeller0@gmail.com"
PASSWORD = find_password(USERNAME)
print(PASSWORD)

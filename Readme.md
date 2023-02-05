<strong>Note</strong>: This only works for Rust code bases

How to use this,
1. Generate RSA key files by running the following,
    `ssh-keygen`
2. Make sure to move the generated key files to `builder` directory
3. Configure `.env` file with all required env variables (refer to `.unset_env` for required envs)
4. Set the env variables by sourcing it (ex: `. .env`)
5. Finally, build the docker image with your app binary using `make build`

References:
https://www.baeldung.com/ops/docker-memory-limit
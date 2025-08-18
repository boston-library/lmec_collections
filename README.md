# BPL
## Running with Docker

### 1. Configure environment variables
Run following command to copy the example file and update values:
```bash
cp .env.development.sample .env.development
```

### 2. Build the application
```bash
docker-compose build
```
This command will build the application image and install dependencies

### 3. Setup the database
If this is the first run, create and migrate the database:
```bash
docker-compose run web bin/rails db:create db:migrate
```

### 4. Run the application
```bash
docker-compose up
```

## Useful Commands
* Start services in the background:

    ```bash
    docker-compose up -d
    ```
* Stop services:

    ```bash
    docker-compose down
    ```
* Open Rails console:

    ```bash
    docker-compose run web bin/rails console
    ```
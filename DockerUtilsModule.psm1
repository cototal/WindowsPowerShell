function Get-ItemsMatchingWord($word) {
    docker run -it -v ${PWD}:/tmp --rm polysphere/utils ack $word
}
Set-Alias dack Get-ItemsMatchingWord

function Invoke-BashInContainer($container) {
    docker exec -it $container /bin/bash
}
Set-Alias dbash Invoke-BashInContainer

function Invoke-StartInContainer($container) {
    docker exec -it $container npm start
}
Set-Alias dstart Invoke-StartInContainer

function Invoke-SymfonyTail($container) {
    docker exec -it $container tail -f var/log/dev.log
}
Set-Alias dstail Invoke-SymfonyTail

function Invoke-SymfonyRun($container) {
    docker exec -it $container php bin/console server:run 0.0.0.0:4000
}
Set-Alias dsrun Invoke-SymfonyRun

function Invoke-SymfonyPsysh($container) {
    docker exec -it $container php bin/console psysh
}
Set-Alias dsysh Invoke-SymfonyPsysh

function Invoke-MongoClient($container = "mongo", $network = "primary") {
    docker run -it --rm --network $network mongo mongo --host $container
}
Set-Alias dgo Invoke-MongoClient

function Invoke-MySQLClient($image = "mysql:8", $network = "primary") {
    docker run -it --rm -v ${PWD}:/data --network $network $image bash
}
Set-Alias dsql Invoke-MySQLClient

function Out-DockerCommands() {
    Write-Output "dack(word) - ack for word from utils container"
    Write-Output "dbash(container) - run bash from specified container"
    Write-Output "dstart(container) - npm start from specified container"
    Write-Output "dstail(container) - tail Symfony log of specified container"
    Write-Output "dsrun(container) - run symfony server from specified container"
    Write-Output "dsysh(container) - run psysh from specified container"
    Write-Output "dgo(container[mongo], network[primary]) - client for running MongoDB service"
    Write-Output "dsql(image[mysql:8], network[primary]) - client for running SQL service"
}
Set-Alias dcmd Out-DockerCommands
Set-Alias dcmds Out-DockerCommands

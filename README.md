```
docker build -t hide/rails-globalize-test .
docker create -t --name rails-globalize-test \
                -v `pwd`:/var/myapp \
                -p 3999:3000 \
                hide/rails-globalize-test
docker exec -it rails-globalize-test sh
```

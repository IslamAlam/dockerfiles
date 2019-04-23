#!/bin/bash -eux
docker-compose up -d
docker-compose exec perforce p4 login
docker-compose exec perforce p4 sync -q --parallel threads=16,batch=64 //sw/eris/... //sw/gpgpu/eris/cuda.vlcp
docker-compose exec perforce sed -i '352 a\
                args.append("--parallel")\
                args.append("threads=16,batch=64")' /p4/sw/eris/src/common/perforce.py
docker-compose exec perforce vulcan --sync ]=cublas_tests
docker-compose exec perforce vulcan --install ]cuda

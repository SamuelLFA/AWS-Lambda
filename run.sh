# 1o step - create file of security policies
# 2o step - create security role on AWS

aws iam create-role \
    --role-name lambda-example \
    --assume-role-policy-document file://policy.json \
    | tee logs/role.log

# 3o step - create file with the content and zip

aws lambda create-function \
    --function-name hello-cli \
    --zip-file fileb://function.zip \
    --handler index.handler \
    --runtime nodejs12.x \
    --role {*arn*}/lambda-example \
    | tee logs/lambda-create.log

# 4o step invoke lambda!
aws lambda invoke \
    --function-name hello-cli \
    --log-type Tail \
    logs/lambda-exec.log

# -- update, zip

# update lambda
aws lambda update-function-code \
    --zip-file fileb://function.zip \
    --function-name hello-cli \
    --publish \
    | tee logs/lambda-update.log

# invoke again
aws lambda invoke \
    --function-name hello-cli \
    --log-type Tail \
    logs/lambda-update.log

# remover
aws lambda delete-function \
    --function-name hello-cli

aws iam delete-role \
    --role-name lambda-example
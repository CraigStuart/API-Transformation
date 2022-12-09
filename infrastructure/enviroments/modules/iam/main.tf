# Create a role for ecs execution
resource "aws_iam_role" "ecs_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Create a policy in order for ECS executor rule to pull in environmental variables
resource "aws_iam_policy" "policy" {
  name        = "s3-access-policy"
  description = "A s3 access policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
                ],
            "Resource": ["arn:aws:s3:::api-transformation-variables*", "arn:aws:s3:::api-transformation-variables"]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3-access-ecs-executor" {
  policy_arn = aws_iam_policy.policy.arn
  role = aws_iam_role.ecs_role.name
}

resource "aws_iam_role_policy_attachment" "kafka-access-ecs-executor" {
  policy_arn = aws_iam_policy.kafka.arn
  role = aws_iam_role.ecs_role.name
}

resource "aws_iam_policy" "kafka" {
  policy = data.aws_iam_policy_document.kafka.json
}

data "aws_iam_policy_document" "kafka" {

  statement {
    sid       = "AllowKafkaPermissions"
    effect    = "Allow"
    resources = ["*"]
    actions   = [
      "kafka:*",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeRouteTables",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeVpcAttribute",
      "kms:DescribeKey",
      "kms:CreateGrant",
      "logs:CreateLogDelivery",
      "logs:GetLogDelivery",
      "logs:UpdateLogDelivery",
      "logs:DeleteLogDelivery",
      "logs:ListLogDeliveries",
      "logs:PutResourcePolicy",
      "logs:DescribeResourcePolicies",
      "logs:DescribeLogGroups",
      "S3:GetBucketPolicy",
    ]
  }
}

#todo remove hard-coding

# Create a role for lambda execution
# Create lambda role and permissions to SQS
resource "aws_iam_role" "lambda_role" {
  name = "lambda-execution-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "default" {
  policy_arn = aws_iam_policy.default.arn
  role = aws_iam_role.lambda_role.name
}

#Add MSK/kafka permissisons to lambda execution role
resource "aws_iam_role_policy_attachment" "kafka-access-lambda-executor" {
  policy_arn = aws_iam_policy.kafka.arn
  role = aws_iam_role.lambda_role.name
}

#Add general lambda policy to lambda role
resource "aws_iam_policy" "default" {
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {

  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:eu-cenral-1:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:ap-southeast-1:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }
  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:eu-central-1:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
  statement {
    sid       = "AllowKmsDecrytion"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["kms:Decrypt"]
  }
}



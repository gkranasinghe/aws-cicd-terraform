# codepipeline IAM permissions

resource "aws_iam_role" "codepipeline_trigger_role" {
  tags = local.tags
  name = "${module.unique_label.name}-codepipeline_trigger_role"
  assume_role_policy = jsonencode({

    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "codepipeline:StartPipelineExecution"
        ],
        "Resource" : [
          join(":", ["arn:aws:codepipeline", var.aws_region, var.aws_account_id, "*"])
        ]
      }
    ]
  })

}
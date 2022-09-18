#TODO: add resources , detail ,  within event_pattern  
resource "aws_cloudwatch_event_rule" "commit" {
  tags        = local.tags
  name        = "capture_commit"
  description = "Capture commit to the codecommit repository"
  role_arn    = aws_iam_role.codepipeline_trigger_role.arn

  event_pattern = jsonencode({
    "source" : [
      "aws.codecommit"
    ],
    "detail-type" : [
      "CodeCommit Repository State Change"
    ],
  })


}


resource "aws_cloudwatch_event_target" "codepipeline" {

  rule      = aws_cloudwatch_event_rule.commit.name
  target_id = "SendToCodepipeline"
  arn       = aws_codepipeline.codepipeline.arn
}


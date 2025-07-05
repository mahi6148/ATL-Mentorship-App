import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { teamTableLambda } from './functions/team-handler/resource';
import { Effect, Policy, PolicyStatement } from 'aws-cdk-lib/aws-iam';
import { Stack } from 'aws-cdk-lib';
import { EventSourceMapping, StartingPosition } from 'aws-cdk-lib/aws-lambda';
import { DynamoEventSource } from 'aws-cdk-lib/aws-lambda-event-sources';

const backend = defineBackend({
  auth,
  data,
  teamTableLambda
});

const fn = backend.teamTableLambda;
const UserTable = backend.data.resources.tables['UserTable'];
const TeamTable = backend.data.resources.tables['TeamTable'];

fn.addEnvironment("UserTableName",UserTable.tableName);
fn.addEnvironment("TeamTableName",TeamTable.tableName);

fn.resources.lambda.addEventSource(new DynamoEventSource(TeamTable,{startingPosition:StartingPosition.LATEST}))

const policy = new Policy(
  Stack.of(TeamTable),
  "MyTeamTableFunctionStreamingPolicy",
  {
    statements:[
      new PolicyStatement({
        effect:Effect.ALLOW,
        actions: [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem"
    ],
    resources: [
      "*"
    ]
      })
    ]
  }
);

fn.resources.lambda.role?.attachInlinePolicy(policy);

// const mapping = new EventSourceMapping(
//   Stack.of(TeamTable),
//   "MyTeamTableFunctionStreamMapping",
//   {
//     target:fn.resources.lambda,
//     eventSourceArn:TeamTable.tableStreamArn,
//     startingPosition:StartingPosition.LATEST
//   }
// );

// mapping.node.addDependency(policy);



import type { DynamoDBRecord, DynamoDBStreamHandler } from "aws-lambda";
import { Logger } from "@aws-lambda-powertools/logger";
import { DynamoDBClient, ReturnValue } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, UpdateCommand } from '@aws-sdk/lib-dynamodb';
import { env } from '$amplify/env/team-table-function'; // the import is '$amplify/env/<function-name>'


const logger = new Logger({
  logLevel: "INFO",
  serviceName: "team-table-stream-handler",
});

const dynamoDBClient = new DynamoDBClient({region:'ap-south-1'});
const docClient = DynamoDBDocumentClient.from(dynamoDBClient);


export const handler:DynamoDBStreamHandler= async(event)=>{
  for (const record of event.Records ){
    if(record.eventName=="INSERT"){
       await InserOperation(record);
    }else if(record.eventName=="MODIFY"){
       await UpdateOperation(record);
    }else if(record.eventName =="REMOVE"){
      await DeleteOperation(record);
    }else{
      logger.info(`invalid operation logging : ${JSON.stringify(record.dynamodb)}by user ${JSON.stringify(record.userIdentity)} `);
    }
  }
};

async function InserOperation(record: DynamoDBRecord) {
  try{
    logger.info(`New data entered into Team table`);
  const newImage = record.dynamodb?.NewImage
  const teamCode = newImage?.team_code.S
  const teamMembers = newImage?.team_members.L

    // Check if teamMembers exists and is an array
  if (!teamMembers || !Array.isArray(teamMembers)) {
    logger.info(`team code is ${teamCode}, team members are ${teamMembers}`)
    logger.warn('No team_members found or team_members is not an array');
    return;
  }
  
  // Check if teamCode exists
  if (!teamCode) {
    logger.info(`team code is :${teamCode}`);
    logger.warn('No team_code found in the record');
    return;
  }
  
  logger.info(`Processing ${teamMembers.length} team members for team code: ${teamCode}`);

    for (const member of teamMembers) {
      const userId = member.S; // Assuming members are stored as string values
      logger.info("passed step 1");
      
      if (userId) {
        logger.info(`passed step 2: ${userId}`);
          // Update the user table with the new team code
           const updateParams = {
            TableName: env.UserTableName || 'users', // Make sure to set this environment variable
            Key: {
              id: userId
            },
            UpdateExpression: 'SET team_code = :teamCode',
            ExpressionAttributeValues: {
              ':teamCode': teamCode
            },
            ReturnValues: ReturnValue.ALL_NEW
          };

          logger.info(`passed step 3 ,Update parameters: ${JSON.stringify(updateParams, null, 2)}`);
          
           try {
          logger.info(`About to execute DynamoDB update for user: ${userId}`);
          
          const result = await docClient.send(new UpdateCommand(updateParams));
          
          logger.info(`✅ SUCCESS: Updated user ${userId} with team code ${teamCode}`);
          logger.info(`Update result: ${JSON.stringify(result, null, 2)}`);
          
        } catch (updateError: any) {
          logger.error(`❌ DynamoDB Update Error for user ${userId}:`);
          logger.error(`Error Name: ${updateError.name}`);
          logger.error(`Error Message: ${updateError.message}`);
          logger.error(`Error Code: ${updateError.code || 'N/A'}`);
          logger.error(`Status Code: ${updateError.$metadata?.httpStatusCode || 'N/A'}`);
          logger.error(`Full Error: ${JSON.stringify(updateError, null, 2)}`);
          
          // Don't throw here, continue with other members
        }
        }
      }
  }catch(e:any){
      logger.info(e);
  }
}

async function UpdateOperation(record: DynamoDBRecord) {
  const newImage = record.dynamodb?.NewImage
  const teamCode = newImage?.team_code.S
  const teamMembers = newImage?.team_members.L

    // Check if teamMembers exists and is an array
  if (!teamMembers || !Array.isArray(teamMembers)) {
    logger.info(`team code is ${teamCode}, team members are ${teamMembers}`)
    logger.warn('No team_members found or team_members is not an array');
    return;
  }
  
  // Check if teamCode exists
  if (!teamCode) {
    logger.warn('No team_code found in the record');
    return;
  }
  
  logger.info(`Processing ${teamMembers.length} team members for team code: ${teamCode}`);

  for (const member of teamMembers) {
      const userId = member.S; // Assuming members are stored as string values
      
      if (userId) {
          // Update the user table with the new team code
           const updateParams = {
            TableName: env.UserTableName || 'users', // Make sure to set this environment variable
            Key: {
              id: userId
            },
            UpdateExpression: 'SET team_code = :teamCode',
            ExpressionAttributeValues: {
              ':teamCode': teamCode
            },
            ReturnValues: ReturnValue.UPDATED_NEW
          };
          
          const result = await docClient.send(new UpdateCommand(updateParams));
          logger.info(`Successfully updated user ${userId} with team code ${teamCode}`);
        }
      }


};


async function DeleteOperation(record: DynamoDBRecord) {
  const oldImage = record.dynamodb?.OldImage
  const teamCode = oldImage?.team_code.S
  const teamMembers = oldImage?.team_members.L
    
    if (!teamCode || !teamMembers) {
      logger.warn(`Missing team code or members in update record`);
      return;
    }

    for (const member of teamMembers) {
      const userId = member.S; // Assuming members are stored as string values
      
      if (userId) {
          // Update the user table with the new team code
           const updateParams = {
            TableName: env.UserTableName || 'users', // Make sure to set this environment variable
            Key: {
              id: userId
            },
            UpdateExpression: 'SET team_code = null ',
            ExpressionAttributeValues: {
              ':teamCode': null
            },
            ReturnValues: ReturnValue.NONE
          };
          
          const result = await docClient.send(new UpdateCommand(updateParams));
          logger.info(`Successfully updated user ${userId} with team code ${teamCode}`);
        }
      }
}

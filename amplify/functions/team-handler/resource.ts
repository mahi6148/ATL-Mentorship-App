import { defineFunction } from "@aws-amplify/backend";
import { data } from "../../data/resource";

export const teamTableLambda = defineFunction({
  name: "team-table-function",
  resourceGroupName: "data",
  entry: "./handler.ts",
  environment:{
    "UserTableName":"sample-User-TableName",
    "TeamTableName":"sample-Team-TableName"
  }
});
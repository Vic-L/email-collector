// Load the AWS SDK for Node.js
const AWS = require('aws-sdk');

// Set the region 
AWS.config.update({region: 'eu-west-1'});

// Create the DynamoDB service object
const ddb = new AWS.DynamoDB({apiVersion: '2012-08-10'});

exports.handler = async (event) => {
  console.log(JSON.stringify(event, null, 2));
  const params = {
    TableName: 'todo-dynamodb_table',
    Item: {
      'email' : {S: event.email}
    }
  };

  // Call DynamoDB to add the item to the table
  ddb.putItem(params, function(err, data) {
    if (err) {
      console.log("Error", err);
      const response = {
        statusCode: 500,
      };
      return response;
    } else {
      console.log("Success", data);
      const response = {
        statusCode: 204,
        headers: {
          "Access-Control-Allow-Origin" : "*",
          "Access-Control-Allow-Credentials": "true"
        },
      };
      return response;
    }
  });
  
  try {
    const result = await ddb.putItem(params).promise();
    console.log("Success", JSON.stringify(result, null, 2));
  }
  catch(err) {
    console.log(err);
  }

  const response = {
    statusCode: 204,
  };
  return response;
};

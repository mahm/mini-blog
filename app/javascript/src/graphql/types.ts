/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

// ====================================================
// GraphQL query operation: topicsQuery
// ====================================================

export interface topicsQuery_topics_user {
  __typename: "User";
  id: string;
  name: string;
}

export interface topicsQuery_topics {
  __typename: "Topic";
  id: string;
  body: string;
  createdAt: any;
  user: topicsQuery_topics_user;
}

export interface topicsQuery {
  topics: topicsQuery_topics[];
}

/* tslint:disable */
/* eslint-disable */
// @generated
// This file was automatically generated and should not be edited.

//==============================================================
// START Enums and Input Objects
//==============================================================

//==============================================================
// END Enums and Input Objects
//==============================================================

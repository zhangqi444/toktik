const axios = require('axios');
const graphql = require('graphql');
const { print } = graphql;
const gql = require('graphql-tag');
const { constants } = require('../index');

/**
 * Common interface for graphql query and mutation.
 * @param {*} data 
 * @param {*} queryName 
 * @returns 
 */
const query = async (data, queryName) => {
    const graphqlData = await axios({
        url: process.env.API_TOKTIK_GRAPHQLAPIENDPOINTOUTPUT,
        method: 'post',
        headers: { 'x-api-key': process.env.API_TOKTIK_GRAPHQLAPIKEYOUTPUT },
        data
    });
    if(graphqlData.data.errors) {
        console.error(graphqlData.data.errors)
        throw new Error(graphqlData.data.errors);
    }
    return graphqlData.data.data[queryName];
};

// query
const getCategorizationByName = async (name) => {
    const q = {
        query: print(gql`
            query getCategorizationByName($name: String) {
                getCategorizationByName(name: $name) {
                    items { id }
                }
            }
        `),
        variables: { name }
    };
    return await query(q, "getCategorizationByName");
}

const getTagByName = async (name) => {
    const q = {
        query: print(gql`
            query getTagByName($name: String) {
                getTagByName(name: $name) {
                    items { id }
                }
            }
        `),
        variables: { name }
    };
    return await query(q, "getTagByName");
}

const getUserByUsername = async (username) => {
    const q = {
        query: print(gql`
            query getUserByUsername($username: String) {
                getUserByUsername(username: $username) {
                    items { id }
                }
            }
        `),
        variables: { username }
    };
    return await query(q, "getUserByUsername");
}

const listPosts = async (args) => {
    const { nextToken, limit, filter } = args;
    return await query({
        query: print(gql`
            query listPosts($filter: ModelPostFilterInput, $limit: Int, $nextToken: String) {
                listPosts(filter: $filter, limit: $limit, nextToken: $nextToken) {
                    nextToken startedAt items {
                        id text attachments likeCount commentCount shareCount viewCount source
                        postCategorizationId postTagIds formatType isBlocked isImported
                        user { id _deleted _lastChangedAt _version bio birth city
                            createdAt gender nickname portrait profession updatedAt username }
                        music { id _deleted _lastChangedAt _version img url createdAt updatedAt }
                    }
                }
            }
        `),
        variables: { filter, limit, nextToken }
    }, 'listPosts');
}

const listCategorizations = async (args) => {
    const { nextToken, limit, filter } = args;
    return await query({
        query: print(gql`
            query listCategorizations($filter: ModelCategorizationFilterInput, $limit: Int, $nextToken: String) {
                listCategorizations(filter: $filter, limit: $limit, nextToken: $nextToken) {
                    nextToken startedAt items {
                        id name
                    }
                }
            }
        `),
        variables: { filter, limit, nextToken }
    }, 'listCategorizations');
}

const listNotInterestedsByUserId = async (userId) => {
    const data = {
        query: print(gql`
            query listNotInteresteds($filter: ModelNotInterestedFilterInput, $limit: Int, $nextToken: String) {
                listNotInteresteds(filter: $filter, limit: $limit, nextToken: $nextToken) {
                    nextToken startedAt items {
                        id notInterestedPostId notInterestedTargetUserId type
                    }
                }
            }
        `),
        variables: { filter: { notInterestedUserId: { eq: userId } } }
    };
    return await query(data, "listNotInteresteds");
}

const getPostsOrderedByCreatedAt = async (sortDirection, limit, mask, nextToken) => {
    const q = {
        query: print(gql`
            query getPostsOrderedByCreatedAt{
                getPostsOrderedByCreatedAt(limit: ${limit}, sortier: ${constants.GRAPHQL_SORTIER}, sortDirection: ${sortDirection}, nextToken: ${nextToken || null}) {
                    items { ${mask || "id createdAt"} }
                }
            }
        `),
    };
    return await query(q, "getPostsOrderedByCreatedAt");
}

// mutation

const createCategorization = async (input) => {
    const data = {
        query: print(gql`
            mutation createCategorization($input: CreateCategorizationInput!) {
                createCategorization(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createCategorization");
}

const createTag = async (input) => {
    const data = {
        query: print(gql`
            mutation createTag($input: CreateTagInput!) {
                createTag(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createTag");
}

const createUser = async (input) => {
    const data = {
        query: print(gql`
            mutation createUser($input: CreateUserInput!) {
                createUser(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createUser");
}

const createPost = async (input) => {
    const data = {
        query: print(gql`
            mutation createPost($input: CreatePostInput!) {
                createPost(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createPost");
}


const updatePost = async (input) => {
    const data = {
        query: print(gql`
            mutation updatePost($input: UpdatePostInput!) {
                updatePost(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "updatePost");
}

module.exports = {
    query,

    getUserByUsername,
    getCategorizationByName,
    getTagByName,
    listPosts,
    listCategorizations,
    listNotInterestedsByUserId,
    getPostsOrderedByCreatedAt,

    createPost,
    createUser,
    createTag,
    createCategorization,
    updatePost,
};
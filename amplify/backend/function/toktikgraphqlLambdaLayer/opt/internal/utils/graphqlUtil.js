const axios = require('axios');
const graphql = require('graphql');
const { print } = graphql;
const gql = require('graphql-tag');

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
const getCategoryByName = async (name) => {
    const q = {
        query: print(gql`
            query getCategoryByName($name: String) {
                getCategoryByName(name: $name) {
                    items { id }
                }
            }
        `),
        variables: { name }
    };
    return await query(q, "getCategoryByName");
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
                        id text attachments likeCount commentCount shareCount viewCount
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

// mutation

const createCategory = async (input) => {
    const data = {
        query: print(gql`
            mutation createCategory($input: CreateCategoryInput!) {
                createCategory(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createCategory");
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

module.exports = {
    query,

    getUserByUsername,
    getCategoryByName,
    getTagByName,
    listPosts,

    createPost,
    createUser,
    createTag,
    createCategory,
};
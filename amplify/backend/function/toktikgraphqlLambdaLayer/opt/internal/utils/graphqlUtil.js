const axios = require('axios');

/**
 * Common interface for graphql query and mutation.
 * @param {*} data 
 * @param {*} queryName 
 * @returns 
 */
module.exports.query = async (data, queryName) => {
    const graphqlData = await axios({
        url: process.env.API_TOKTIK_GRAPHQLAPIENDPOINTOUTPUT,
        method: 'post',
        headers: { 'x-api-key': process.env.API_TOKTIK_GRAPHQLAPIKEYOUTPUT },
        data
    });
    if(!graphqlData.data.errors) return graphqlData.data.data[queryName];
};

// query
module.exports.getCategoryByName = async (name) => {
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
    const data = await query(q, "getCategoryByName");
    return data && data.items;
}

module.exports.getTagByName = async (name) => {
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
    const data = await query(q, "getTagByName");
    return data && data.items;
}



// mutation

module.exports.createCategory = async (input) => {
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

module.exports.createTag = async (input) => {
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

module.exports.createUser = async (input) => {
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

module.exports.createPost = async (input) => {
    const data = {
        query: print(gql`
            mutation createPost($input: createPostInput!) {
                createPost(input: $input) {
                    id
                }
            }
        `),
        variables: { input }
    };
    return await query(data, "createPost");
}
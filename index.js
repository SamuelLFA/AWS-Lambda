async function handler(event, context) {
    console.log('Ambiente...', JSON.stringify(process.env, null));
    console.log('Evento...', JSON.stringify(event, null, 2));

    return {
        hello: 'jude'
    }
}

module.exports = {
    handler
}
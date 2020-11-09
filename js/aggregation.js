// ФИО: Томчик Никита Сергеевич

// Count of documents in collection `tags`
db.tags.find().count()

// Count of documents in collection `tags` with tag_name equal to 'Adventure'
db.tags.find({"tag_name": "Adventure"}).count()

// Top 3 tags in collection `tags`
db.tags.aggregate(
    [
        {
            $group: {
                // Group all documents by tag_name field
                _id: {tag_name: "$tag_name"},
                // And count documents in group
                count: {$sum: 1},
            },
        },
        // Sort given groups by count field in descending order
        {$sort: {count: -1}},
        // Limit output to 3 documents
        {$limit: 3}
    ]
)

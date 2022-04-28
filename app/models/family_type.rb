class FamilyType < ActiveHash::Base
  self.data = [
    { id: 1, name: 'ひとり暮らし（独身・単身者）' },
    { id: 2, name: '夫婦ふたり暮らし・2人家族' },
    { id: 3, name: '夫婦と小学生以下の子どもの3人家族' },
    { id: 4, name: '夫婦と中高生の子どもの3人家族' },
    { id: 5, name: '夫婦と小学生以下の子どもの4人家族' },
    { id: 6, name: '夫婦と中高生の子どもの4人家族' },
    { id: 7, name: '夫婦と子どもの5人以上家族' }
  ]

  include ActiveHash::Associations
  has_many :users

end
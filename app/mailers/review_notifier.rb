class ReviewNotifier < ApplicationMailer
  def new_review(review)
    @review = review

    mail(
      from: "Never Again Boston"
      to: review.restaurant.user.email,
      subject: "New Review for #{review.restaurant.name}"
      )
  end
end
